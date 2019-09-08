class Relationship < ApplicationRecord
    belongs_to :befriender, class_name: 'Person'
    belongs_to :befriended, class_name: 'Person'
    validates :befriender_id, presence: true
    validates :befriended_id, presence: true
end