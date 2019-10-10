class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @feed_items = current_person.feed.paginate(page: params[:page])
      @new_meeting = Meeting.new
      current_person.befriending.count.times { @new_meeting.people_meetings.build }
      @micropost = current_person.microposts.build
      @note = current_person.notes.build
      @notes = current_person.notes.order(created_at: :desc).paginate(page: params[:page])
      # byebug
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
