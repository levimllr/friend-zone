class RelationshipsController < ApplicationController
  before_action :logged_in_person

  def create
    # byebug
    @person = Person.find(params[:relationship][:befriended_id])
    current_person.befriend(reln_params)
    redirect_to(@person)
    respond_to do |format|
      format.html { redirect_to @person }
      format.js
    end
  end

  def destroy
    @person = Relationship.find(params[:id]).befriended
    current_person.unbefriend(@person)
    redirect_to (relationships_path)
  end

  def index
    @relationships = current_person.active_relationships
  end

  private

  def reln_params
    params.require(:relationship).permit(
      :befriender_id,
      :befriended_id,
      :reln_type,
      :quality,
      :start
    )
  end
end
