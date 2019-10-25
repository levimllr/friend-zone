class Person < ApplicationRecord
    attr_accessor :remember_token, :activation_token, :reset_token

    class << self
        # Returns hash digest of given string
        def digest(string)
            cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost 
            BCrypt::Password.create(string, cost: cost)
        end

        # Returns a random token
        def new_token
            SecureRandom.urlsafe_base64
        end
    end

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    
    before_save :downcase_email
    before_create :create_activation_digest

    validates(:username, presence: true, length: { maximum: 36 })
    # Most of secure password machinery implemented using single Rails method:
    has_secure_password
    validates(:password, presence: true, 
        length: { minimum: 8 }, 
        allow_nil: true)
    validates(:first_name, presence: true)
    validates(:last_name, presence: true)
    validates(:birthday, presence: true)
    validates(:email, presence: true, 
        length: { maximum: 255 }, 
        format: { with: VALID_EMAIL_REGEX }, 
        uniqueness: { case_sensitive: false })
    validates(:phone_number, presence: true)

    # has_many :befriended_persons, foreign_key: :befriender_id, 
    #     class_name: 'Relationship'
    # has_many :befriendees, through: :befriended_persons

    # has_many :befriending_persons, foreign_key: :befriendee_id, 
    #     class_name: 'Relationship'
    # has_many :befrienders, through: :befriending_persons

    has_many :people_meetings
    has_many :meetings, through: :people_meetings

    has_many :notes, dependent: :destroy

    has_many :microposts, dependent: :destroy
    
    has_many :active_relationships, class_name: "Relationship",
        foreign_key: "befriender_id", dependent: :destroy
    has_many :passive_relationships, class_name: "Relationship",
        foreign_key: "befriended_id", dependent: :destroy
    has_many :befriending, through: :active_relationships, source: :befriended
    has_many :befrienders, through: :passive_relationships, source: :befriender

    has_one :love_language

    def full_name
        self.first_name + ' ' + self.last_name
    end

    # Remembers a user in the database for use in persistent sessions
    def remember
        self.remember_token = Person.new_token
        update_attribute(:remember_digest, Person.digest(remember_token))
    end

    # Returns true if the given token matches the digest
    def authenticated?(attribute, token)
        digest = send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end

    def forget
        update_attribute(:remember_digest, nil)
    end

    # Activates an account
    def activate
        # update_columns allows us to update more than one attribute at a time! 
        update_columns(activated: true, activated_at: Time.zone.now)
    end

    # Sends activation email
    def send_activation_email 
        PersonMailer.account_activation(self).deliver_now
    end

    # Sets the password reset attributes
    def create_reset_digest
        self.reset_token = Person.new_token
        update_columns(reset_digest: Person.digest(reset_token), reset_sent_at: Time.zone.now)
    end

    # Sends password reset email
    def send_password_reset_email
        PersonMailer.password_reset(self).deliver_now
    end

    # Returns true if a password reset has expired.
    def password_reset_expired?
        reset_sent_at < 2.hours.ago
    end

    # Returns a person's status feed.
    def feed
        befriending_ids = "SELECT befriended_id FROM relationships
                           WHERE befriender_id = :person_id"
        Micropost.where("person_id IN (#{befriending_ids}) 
            OR person_id = :person_id", person_id: self.id)
    end

    # Returns a person's notes.
    def notes
        Note.where("person_id = #{self.id}")
    end

    # Befriend a person!
    def befriend(reln_params)
        Relationship.create(reln_params)
        # self.befriending << other_person
    end

    # Check to see if person is being befriended.
    def befriending?(other_person)
        self.befriending.include?(other_person)
    end

    # Unbefriend a person :(
    def unbefriend(other_person)
        self.befriending.delete(other_person)
    end

    private

        # Converts email to all lower-case
        def downcase_email
            self.email.downcase!
        end

        # Creates and assigns the activation token and digest
        def create_activation_digest
            self.activation_token = Person.new_token
            self.activation_digest = Person.digest(activation_token)
        end
end
