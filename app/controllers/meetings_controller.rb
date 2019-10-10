class MeetingsController < ApplicationController
  before_action :logged_in_person, only: [:create, :destroy]

  def create
    byebug
    @meeting = Meeting.new
    if @meeting.save
      flash[:success] = 'Meeting created!'
    else
      flash[:danger] = 'Meeting not created. Missing friend, place, or type!'
    end
    current_person.meetings << @meeting
    People.find(meeting_params[:people]) << @meeting
    redirect_to(root_url)
  end

  def index
    @meetings = current_person.meetings
    render('index')
  end

  def show
  end

  def new
  end

  def destroy
  end

  # Only allow note content
  def meeting_params
    # byebug
    params.require(:meeting).permit(
      :meeting_type, :when, :location,
      person_attributes: [:id]
    )
  end
end
