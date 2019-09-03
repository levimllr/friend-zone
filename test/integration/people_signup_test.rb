require 'test_helper'

class PeopleSignupTest < ActionDispatch::IntegrationTest

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

  test "valid signup information" do
    get signup_path
    assert_difference 'Person.count' do
      assert_select 'form[action="/signup"]'
      post signup_path, params: { person: {first_name: "Example", last_name: "Person", birthday: Date.civil(1994, 12, 30), phone_number: 1234567890, username: "exper", email: "person@valid.com", password: "foobarbaz", password_confirmation: "foobarbaz" } }
    end 
    follow_redirect!
    assert_template 'people/show'
    assert_not flash.empty?
    assert is_logged_in?
  end
end
