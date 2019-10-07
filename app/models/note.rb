# Model for private user notes
class Note < ApplicationRecord
  belongs_to :person

  validates :person_id, presence: true
  validates :content, presence: true, length: { maximum: 560 }
end
