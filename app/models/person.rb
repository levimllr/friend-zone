class Person < ApplicationRecord
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    
    before_save { self.email.downcase! }

    validates(:username, presence: true, length: { maximum: 36 })
    # Most of the secure password machinery will be implemented using this single Rails method:
    has_secure_password
    validates(:password, presence: true, length: { minimum: 8 })
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
end
