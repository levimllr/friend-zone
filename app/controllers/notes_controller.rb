# Controller for private user notes
class NotesController < ApplicationController
  before_action :logged_in_person, only: [:create, :destroy]

  # Create a note
  def create
    # byebug
    @note = current_person.notes.build(note_params)
    if @note.save
      flash[:success] = 'Note created!'
      redirect_to root_url
    else
      @notes = []
      render 'static_pages/home'
    end
  end

  private

  # Only allow note content
  def note_params
    # byebug
    params.require(:note).permit(:content)
  end
end