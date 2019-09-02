class PeopleController < ApplicationController
  def new
    @person = Person.new
  end

  def create
    @person = Person.new(person_params)
    if @person.save
      flash[:success] = "Wecome to the Friend Zone!"
      redirect_to @person
    else
      render 'new'
    end
  end

  def show
    @person = Person.find(params[:id])
  end

  private

    def person_params
      params.require(:person).permit(:first_name, :last_name, :phone_number, :birthday, :username, :email, :password, :password_confirmation)
    end
end
