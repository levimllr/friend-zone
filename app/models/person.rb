class Person < ApplicationRecord
    has_many :befriended_persons, foreign_key: :befriender_id, class_name: 'Relationship'
    has_many :befriendees, through: :befriended_persons

    has_many :befriending_persons, foreign_key: :befriendee_id, class_name: 'Relationship'
    has_many :befrienders, through: :befriending_persons

    has_many :people_meetings
    has_many :meetings, through: :people_meetings

    has_many :notes

    has_one :love_language
end
