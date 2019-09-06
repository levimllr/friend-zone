require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
    @person = people(:michael)
  end

  test "password resets" do
    get new_password_reset_path
    assert_template 'password_resets/new'
    # Invalid email
    post password_resets_path, params: { password_reset: { email: "" } }
    assert_not flash.empty?
    assert_template 'password_resets/new'
    # Valid email
    post password_resets_path,
         params: { password_reset: { email: @person.email } }
    assert_not_equal @person.reset_digest, @person.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to root_url
    # Password reset form
    person = assigns(:person)
    # Wrong email
    get edit_password_reset_path(person.reset_token, email: "")
    assert_redirected_to root_url
    # Inactive person
    person.toggle!(:activated)
    get edit_password_reset_path(person.reset_token, email: person.email)
    assert_redirected_to root_url
    person.toggle!(:activated)
    # Right email, wrong token
    get edit_password_reset_path('wrong token', email: person.email)
    assert_redirected_to root_url
    # Right email, right token
    get edit_password_reset_path(person.reset_token, email: person.email)
    assert_template 'password_resets/edit'
    assert_select "input[name=email][type=hidden][value=?]", person.email
    # Invalid password & confirmation
    patch password_reset_path(person.reset_token), params: { email: person.email, person: { password: "foobazzz", password_confirmation: "barquuxx" } }
    assert_select 'div#error_explanation'
    # Empty password
    patch password_reset_path(person.reset_token),
          params: { email: person.email, person: { password: "", password_confirmation: "" } }
    assert_select 'div#error_explanation'
    # Valid password & confirmation
    patch password_reset_path(person.reset_token), params: { email: person.email, person: { password: "foobazzz", password_confirmation: "foobazzz" } }
    # byebug
    assert is_logged_in?
    assert_not flash.empty?
    assert_redirected_to person
  end

  test "expired token" do
    get new_password_reset_path
    # byebug
    post password_resets_path, params: { password_reset: { email: @person.email } }
    @person = assigns(:person)
    @person.update_attribute(:reset_sent_at, 3.hours.ago)
    patch password_reset_path(@person.reset_token), params: { email: @person.email, person: { password:              "foobarrr", password_confirmation: "foobarrr" } }
    assert_response :redirect
    follow_redirect!
    assert_match "Forgot password", response.body
  end
end
