require 'test_helper'

class PersonMailerTest < ActionMailer::TestCase
  test "account_activation" do
    person = people(:michael)
    person.activation_token = Person.new_token
    mail = PersonMailer.account_activation(person)
    assert_equal "Friend Zone Account Activation", mail.subject
    assert_equal [person.email], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match person.first_name, mail.body.encoded
    assert_match person.activation_token, mail.body.encoded
    assert_match CGI.escape(person.email), mail.body.encoded
  end

  test "password_reset" do
    person = people(:michael)
    person.reset_token = Person.new_token
    mail = PersonMailer.password_reset(person)
    assert_equal "Friend Zone Password Reset", mail.subject
    assert_equal [person.email], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match person.reset_token, mail.body.encoded
    assert_match CGI.escape(person.email), mail.body.encoded
  end

end
