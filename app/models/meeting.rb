class Meeting < ApplicationRecord
    has_many :people_meetings
    has_many :people, through: :people_meetings

    def people_string
        self.people.map{|person| person.full_name}.join(", ")
    end

    def stringify
        "#{self.meeting_type.capitalize} with #{people_string} on #{self.when.strftime("%A, %-m/%-d")} at #{self.location}"
    end
end
