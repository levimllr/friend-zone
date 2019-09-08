class PeopleController < ApplicationController
  before_action :logged_in_person, only: [:index, :edit, :update, :destroy,
    :befriending, :befrienders]
  before_action :correct_person, only: [:edit, :update]
  before_action :admin_person, only: :destroy

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(person_params)
    if @person.save
      @person.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def index
    @people = Person.where(activated: true).paginate(page: params[:page])
  end

  def show
    find_current_person
    redirect_to root_url and return unless !@person.activated.nil?
    @microposts = @person.microposts.paginate(page: params[:page])
  end

  def edit
    find_current_person
  end

  def update
    find_current_person
    if @person.update(person_params)
      flash[:success] = "Profile updated"
      redirect_to @person
    else
      render 'edit'
    end
  end

  def destroy
    find_current_person.destroy
    flash[:success] = "Person deleted"
    redirect_to people_url
  end

  def befriending
    @title = "Befriending"
    find_current_person
    @people = @person.befriending.paginate(page: params[:page])
    render 'show_befriend'
  end

  def befrienders
    @title = "Befrienders"
    find_current_person
    @people = @person.befrienders.paginate(page: params[:page])
    render 'show_befriend'
  end

  private

    def person_params
      params.require(:person).permit(:first_name, :last_name, :phone_number, :birthday, :username, :email, :password, :password_confirmation)
    end

    def find_current_person
      @person = Person.find(params[:id])
    end

    # Before filters

    # Confirms the correct person
    def correct_person
      find_current_person
      redirect_to(root_url) unless current_person?(@person)
    end

    # Cofnirms an admin person
    def admin_person
      redirect_to(root_url) unless current_person.admin?
    end
end
