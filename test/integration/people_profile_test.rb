require 'test_helper'

class PeopleProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @person = people(:michael)
  end

  test "profile display" do
    # byebug
    get person_path(@person)
    assert_template 'people/show'
    assert_select 'title', full_title(@person.first_name)
    assert_select 'h1', text: @person.username
    assert_select 'h1>img.gravatar'
    assert_match @person.microposts.count.to_s, response.body
    assert_select 'div.pagination'
    @person.microposts.paginate(page: 1).each do |micropost|
      assert_match micropost.content, response.body
    end
  end
end
