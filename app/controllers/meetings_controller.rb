class MeetingsController < ApplicationController
  before_action :logged_in_person, only: [:create, :destroy]
  before_action :find_meeting_by_id, only: [:show, :edit, :update, :destroy]

  def create
    byebug
    @meeting = Meeting.new(meeting_params)
    if @meeting.save
      flash[:success] = 'Meeting created!'
    else
      flash[:danger] = 'Meeting not created. Missing friend, place, or type!'
    end
    # current_person.meetings << @meeting
    # People.find(meeting_params[:people]) << @meeting
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

  def edit
    @new_meeting = find_meeting_by_id

  end

  def update
    # byebug
    @meeting.update(meeting_params)
    # current_person.meetings << @meeting
    redirect_to(meetings_path)
  end

  def destroy
    @meeting.destroy
    redirect_to(meetings_path)
  end

  # Only allow note content
  def meeting_params
    # byebug
    params.require(:meeting).permit(:meeting_type, :when, :location, person_ids: [])
  end

  def find_meeting_by_id
    @meeting = Meeting.find(params[:id])
  end
end
