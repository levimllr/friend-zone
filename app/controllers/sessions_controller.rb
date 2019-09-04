class SessionsController < ApplicationController
  def new
  end

  def create
    @person = Person.find_by(username: params[:session][:username])
    if @person && @person.authenticate(params[:session][:password])
      log_in @person
      params[:session][:remember_me] == '1' ? remember(@person) : forget(@person)
      redirect_to @person
    else  
      flash.now[:danger] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
