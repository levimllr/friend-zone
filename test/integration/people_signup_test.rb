require 'test_helper'

class PeopleSignupTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'Person.count' do
      assert_select 'form[action="/signup"]'
      post signup_path, params: { person: {first_name: "", last_name: "", birthday: "", phone_number: "", username: "", email: "person@invalid", password: "foo", password_confirmation: "bar" } }
    end
    assert_template 'people/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
  end

  test "valid signup information with account activation" do
    get signup_path
    assert_difference 'Person.count', 1 do
      assert_select 'form[action="/signup"]'
      post signup_path, params: { person: {first_name: "Example", last_name: "Person", birthday: Date.civil(1994, 12, 30), phone_number: 1234567890, username: "exper", email: "person@valid.com", password: "foobarbaz", password_confirmation: "foobarbaz" } }
    end 
    assert_equal 1, ActionMailer::Base.deliveries.size
    # assigns lets us access instance variables in the corresponding action (Person controller's create action)
    # assigns method is deprecated in default Rails tests as of Rails 5, but it’s available via the rails-controller-testing gem
    person = assigns(:person)
    assert_not person.activated?
    # Try to log in before activation.
    log_in_as(person)
    assert_not is_logged_in?
    # Invalid activation token
    get edit_account_activation_path("invalid token", email: person.email)
    assert_not is_logged_in?
    # Valid token, wrong email
    # byebug
    get edit_account_activation_path(person.activation_token, email: 'wrong')
    assert_not is_logged_in?
    # Valid activation token
    get edit_account_activation_path(person.activation_token, email: person.email)
    assert person.reload.activated?
    follow_redirect!
    assert_template 'people/show'
    assert_not flash.empty?
    assert is_logged_in?
  end
end
