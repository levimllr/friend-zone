class PasswordResetsController < ApplicationController
  before_action :get_person, only: [:edit, :update]
  before_action :valid_person, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update] 

  def new
  end
  
  def create
    @person = Person.find_by(email: params[:password_reset][:email].downcase)
    if @person
      @person.create_reset_digest
      @person.send_password_reset_email
      flash[:info] = "Email sent with password reset instructions"
      redirect_to root_url
    else  
      flash.now[:danger] = "Email address not found"
      render 'new'
    end
  end

  def edit
  end

  def update
    if params[:person][:password].empty?                  # Case (3)
      @person.errors.add(:password, "can't be empty")
      render 'edit'
    elsif @person.update_attributes(person_params)          # Case (4)
      log_in @person
      @person.update_attribute(:reset_digest, nil)
      flash[:success] = "Password has been reset."
      redirect_to @person
    else
      render 'edit'                                     # Case (2)
    end
  end

  private

    def person_params
      params.require(:person).permit(:password, :password_confirmation)
    end

    # Before filters

    def get_person
      @person = Person.find_by(email: params[:email])
    end

    # Confirms a valid person
    def valid_person
      unless (@person && @person.activated? && @person.authenticated?(:reset, params[:id]))
        redirect_to root_url
      end
    end

    # Checks expiration of reset token.
    def check_expiration
      if @person.password_reset_expired?
        flash[:danger] = "Password reset has expired."
        redirect_to new_password_reset_url
      end
    end

end
