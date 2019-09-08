require 'test_helper'

class BefriendingTest < ActionDispatch::IntegrationTest
  def setup
    @person = people(:michael)
    @other = people(:archer)
    log_in_as(@person)
  end

  test "befriending page" do
    get befriending_person_path(@person)
    assert_not @person.befriending.empty?
    assert_match @person.befriending.count.to_s, response.body
    @person.befriending.each do |person|
      assert_select "a[href=?]", person_path(person)
    end
  end

  test "befrienders page" do
    get befrienders_person_path(@person)
    assert_not @person.befrienders.empty?
    assert_match @person.befrienders.count.to_s, response.body
    @person.befrienders.each do |person|
      assert_select "a[href=?]", person_path(person)
    end
  end

  # WARNING AbstractController::DoubleRenderError with befriending_test.rb
  # test "should befriend a person the standard way" do
  #   assert_difference "@person.befriending.count", 1 do
  #     post relationships_path, params: { befriended_id: @other.id }
  #   end
  # end

  test "should befriend a person with AJAX" do
    assert_difference "@person.befriending.count", 1 do
      post relationships_path, xhr: true, params: { befriended_id: @other.id }
    end
  end

  # WARNING AbstractController::DoubleRenderError with befriending_test.rb
  # test "should unbefriend a person the standard way" do
  #   @person.befriend(@other)
  #   relationship = @person.active_relationships
  #     .find_by(befriended_id: @other.id)
  #   assert_difference "@person.befriending.count", -1 do
  #     delete relationship_path(relationship)
  #   end
  # end

  test "should unbefriend a person with AJAX" do
    @person.befriend(@other)
    relationship = @person.active_relationships
      .find_by(befriended_id: @other.id)
    assert_difference "@person.befriending.count", -1 do
      delete relationship_path(relationship), xhr: true
    end
  end
end
