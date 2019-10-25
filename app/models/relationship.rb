class Relationship < ApplicationRecord
  belongs_to :befriender, class_name: 'Person'
  belongs_to :befriended, class_name: 'Person'
  validates :befriender_id, presence: true
  validates :befriended_id, presence: true

  def stringify
    "#{self.befriender.first_name} & #{self.befriended.first_name}, since #{self.start.strftime("%-m/%-d/%Y")}. #{self.quality}-grade #{self.reln_type}"
  end

  def stringify_short
    "#{self.quality}-grade #{self.reln_type} since #{self.start.strftime("%-m/%-d/%Y")}"
  end
end
