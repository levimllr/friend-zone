# Model for private user notes
class Note < ApplicationRecord
  belongs_to :person

  validates :person_id, :title, presence: true
  validates :content, presence: true, length: { maximum: 560 }

  def stringify
    meeting = !!people_meeting_id == true ? PeopleMeeting.find(people_meeting_id).meeting : nil
    friend = !!friend_id == true ? Person.find(friend_id) : nil
    if friend_id && people_meeting_id
      "#{meeting.meeting_type.capitalize} with #{friend.full_name} 
      on #{meeting.when.strftime('%A, %-m/%-d')} at #{meeting.location}."
    elsif people_meeting_id
      meeting.stringify
    elsif friend_id
      "#{friend.full_name}."
    else
      "Personal."
    end
  end
end
