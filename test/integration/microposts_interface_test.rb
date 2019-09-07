require 'test_helper'

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest
  
  def setup
    @person = people(:michael)
  end

  test "micropost interface" do
    log_in_as(@person)
    get root_path
    assert_select 'div.pagination'
    assert_select 'input[type=file]'
    # Invalid submission
    assert_no_difference 'Micropost.count' do
      post microposts_path, params: { micropost: { content: "" } }
    end
    assert_select 'div#error_explanation'
    # Valid submission
    content = "This micropost really ties the room together!"
    picture = fixture_file_upload('test/fixtures/rails.png', 'image/png')
    assert_difference 'Micropost.count', 1 do
      post microposts_path, params: { micropost: 
                                      { content: content,
                                        picture: picture } }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body
    # Delete post
    assert_select 'a', text: 'delete'
    first_micropost = @person.microposts.paginate(page: 1).first
    assert_difference 'Micropost.count', -1 do
      delete micropost_path(first_micropost)
    end
    # Visit different person (no delete links)
    get person_path(people(:archer))
    assert_select 'a', text: 'delete', count: 0
  end

  test "micropost sidebar count" do
    log_in_as(@person)
    get root_path
    assert_match "31 microposts", response.body
    # Person with zero microposts
    other_person = people(:malory)
    log_in_as(other_person)
    get root_path
    assert_match "1 micropost", response.body
    other_person.microposts.create!(content: "A micropost")
    get root_path
    assert_match "2 micropost", response.body
  end
end
