ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  # Returns true if person logged in 
  def is_logged_in?
    !session[:person_id].nil?
  end

  # Log in as particular person
  def log_in_as(person)
    session[:person_id] = person.id
  end
end

class ActionDispatch::IntegrationTest

  # Log in as a particular person.
  def log_in_as(person, password: 'password', remember_me: '1')
    post login_path, params: { session: { username: person.username, password: password, remember_me: remember_me } }
  end
end