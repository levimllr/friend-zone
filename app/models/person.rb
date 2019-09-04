class Person < ApplicationRecord
    attr_accessor :remember_token, :activation_token

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
    # Most of the secure password machinery will be implemented using this single Rails method:
    has_secure_password
    validates(:password, presence: true, length: { minimum: 8 }, allow_nil: true)
    validates(:first_name, presence: true)
    validates(:last_name, presence: true)
    validates(:birthday, presence: true)
    validates(:email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false })
    validates(:phone_number, presence: true)


    has_many :befriended_persons, foreign_key: :befriender_id, class_name: 'Relationship'
    has_many :befriendees, through: :befriended_persons

    has_many :befriending_persons, foreign_key: :befriendee_id, class_name: 'Relationship'
    has_many :befrienders, through: :befriending_persons

    has_many :people_meetings
    has_many :meetings, through: :people_meetings

    has_many :notes

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
    def authenticated?(remember_token)
        return false if remember_digest.nil?
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

    def forget
        update_attribute(:remember_digest, nil)
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
