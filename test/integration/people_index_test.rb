require 'test_helper'

class PeopleIndexTest < ActionDispatch::IntegrationTest
  def setup
    @admin = people(:michael)
    @nonadmin = people(:archer)
  end

  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    get people_path
    assert_template 'people/index'
    assert_select 'div.pagination'
    first_page_of_people = Person.paginate(page: 1)
    first_page_of_people.each do |person|
      assert_select 'a[href=?]', person_path(person), text: person.full_name
      unless person == @admin
        assert_select 'a[href=?]', person_path(person), text: 'delete'
      end
    end
    assert_difference 'Person.count', -1 do
      delete person_path(@nonadmin)
    end
  end

  test "index as nonadmin" do
    log_in_as(@nonadmin)
    get people_path
    assert_select 'a', text: 'delete', count: 0
  end
end
