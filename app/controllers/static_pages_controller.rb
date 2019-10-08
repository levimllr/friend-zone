class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @feed_items = current_person.feed.paginate(page: params[:page])
      @notes = current_person.notes.paginate(page: params[:page])
      @micropost = current_person.microposts.build
      @note = current_person.notes.build
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
