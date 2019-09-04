require 'test_helper'

class PeopleEditTest < ActionDispatch::IntegrationTest
  def setup
    @person = people(:michael)
  end

  test "unsuccessful edit" do
    log_in_as(@person)
    get edit_person_path(@person)
    assert_template 'people/edit'
    patch person_path(@person), params: { person: {first_name: "", last_name: "", birthday: "", phone_number: "", username: "", email: "person@invalid", password: "foo", password_confirmation: "bar" } }
    assert_template "people/edit"
    assert_select "div.alert", "This form contains 8 errors."
  end

  test "successful edit with friendly forwarding" do
    get edit_person_path(@person)
    log_in_as(@person)
    assert_redirected_to edit_person_url(@person)
    assert_nil session[:forwarding_url]
    username = "ghold"
    email = "gholdtstadt@example.org"
    patch person_path(@person), params: { person: { first_name: "Gretchin", last_name: "Holdtstadt", birthday: Date.civil(1976, 4, 16), phone_number: 8936745091, username: username, email: email, password: "", password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @person
    @person.reload
    assert_equal username, @person.username
    assert_equal email, @person.email
  end

end
