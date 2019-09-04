require 'test_helper'

class PeopleControllerTest < ActionDispatch::IntegrationTest
  def setup
    @person = people(:michael)
    @other_person = people(:archer)
  end

  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "should redirect edit when logged in as wrong person" do
    log_in_as(@other_person)
    get edit_person_path(@person)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_person)
    username = "ghold"
    email = "gholdtstadt@example.org"
    patch person_path(@person), params: { person: { first_name: "Gretchin", last_name: "Holdtstadt", birthday: Date.civil(1976, 4, 16), phone_number: 8936745091, username: username, email: email, password: "", password_confirmation: "" } }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect index when not logged in" do
    get people_path
    assert_redirected_to login_url
  end

  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@other_person)
    assert_not @other_person.admin?
    username = "ghold"
    email = "gholdtstadt@example.org"
    patch person_path(@other_person), params: { person: { first_name: "Gretchin", last_name: "Holdtstadt", birthday: Date.civil(1976, 4, 16), phone_number: 8936745091, username: username, email: email, password: "", password_confirmation: "", admin: true } }
    assert_not @other_person.admin?
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Person.count' do
      delete person_path(@person)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged as a non-admin" do
    log_in_as(@other_person)
    assert_no_difference 'Person.count' do
      delete person_path(@person)
    end
    assert_redirected_to root_url
  end
end
