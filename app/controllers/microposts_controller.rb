# MicropostsController
class MicropostsController < ApplicationController
  before_action :logged_in_person, only: [:create, :destroy]
  before_action :correct_person, only: :destroy

  def create
    @micropost = current_person.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = 'Micropost created!'
    else
      flash[:danger] = 'Missing content for micropost!'
    end
    redirect_to root_url
  end

  def destroy
    @micropost.destroy
    flash[:success] = 'Micropost deleted!'
    redirect_back(fallback_location: root_url)
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :picture)
  end

  def correct_person
    @micropost = current_person.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end
end
