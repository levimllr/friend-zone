require 'test_helper'

class PeopleEditTest < ActionDispatch::IntegrationTest
  def setup
    @person = people(:michael)
  end

  test "unsuccesful edit" do
    get edit_person_path(@person)
    assert_template 'people/edit'
    patch person_path(@person), params: { person: {first_name: "", last_name: "", birthday: "", phone_number: "", username: "", email: "person@invalid", password: "foo", password_confirmation: "bar" } }
    assert_template "people/edit"
  end
end
