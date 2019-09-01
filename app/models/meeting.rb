class Meeting < ApplicationRecord
    has_many :people_meetings
    has_many :people, through: :people_meetings
end
