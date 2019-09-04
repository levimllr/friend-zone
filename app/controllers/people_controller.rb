class PeopleController < ApplicationController
  def new
    @person = Person.new
  end

  def create
    @person = Person.new(person_params)
    if @person.save
      log_in @person
      flash[:success] = "Wecome to the Friend Zone!"
      redirect_to @person
    else
      render 'new'
    end
  end

  def show
    find_current_person
  end

  def edit
    find_current_person
  end

  def update
    find_current_person
    if @person.update(person_params)
      
    else
      render 'edit'
    end
  end

  private

    def person_params
      params.require(:person).permit(:first_name, :last_name, :phone_number, :birthday, :username, :email, :password, :password_confirmation)
    end

    def find_current_person
      @person = Person.find(params[:id])
    end
end
