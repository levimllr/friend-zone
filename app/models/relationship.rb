class Relationship < ApplicationRecord
    belongs_to :befriender, class_name: 'Person'
    belongs_to :befriendee, class_name: 'Person'
end