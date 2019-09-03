class SessionsController < ApplicationController
  def new
  end

  def create
    person = Person.find_by(username: params[:session][:username])
    if person && person.authenticate(params[:session][:password])
      log_in person
      redirect_to person
    else  
      flash.now[:danger] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
