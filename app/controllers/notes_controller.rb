# Controller for private user notes
class NotesController < ApplicationController
  before_action :logged_in_person, only: [:create, :destroy]

  # Create a note
  def create
    # byebug
    @note = current_person.notes.build(note_params)
    if @note.save
      flash[:success] = 'Note created!'
      # redirect_to root_url
    else
      # byebug
      # @notes = []
      # render 'static_pages/home'
      flash[:danger] = 'Note not created. Missing title and/or content!'
    end
    redirect_to root_url
  end

  def index
    @notes = Note.where(person_id: current_person.id).order(created_at: :desc).paginate(page: params[:page])
  end

  private

  # Only allow note content
  def note_params
    # byebug
    params.require(:note).permit(:content, :person_id, :friend_id, :people_meeting_id, :title)
  end
end