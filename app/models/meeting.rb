class Meeting < ApplicationRecord
    has_many :people_meetings
    has_many :people, through: :people_meetings
    accepts_nested_attributes_for(:people_meetings)

    def people_string
        self.people.map{|person| person.full_name}.join(", ")
    end

    def people_string_short
        head_count = self.people.length
        people_names = self.people.map{|person| person.first_name}
        if head_count > 3
            return people_names[0..2].join(", ") + ", and friends"
        elsif head_count == 2
            return people_names[0] + " and " + people_names[1]
        else  
            return people_names[0]
        end
    end

    def stringify
        "#{self.meeting_type.capitalize} with #{people_string} on #{self.when.strftime("%A, %-m/%-d")} at #{self.location}"
    end

    def stringify_short
        # byebug
        "#{self.meeting_type.capitalize} with #{people_string_short} on #{self.when.strftime("%-m/%-d")} at #{self.location}"
    end

    def notes
        Note.all.select do |note|
            note.meeting == self
        end
    end
end
