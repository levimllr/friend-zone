require 'test_helper'

class PersonMailerTest < ActionMailer::TestCase
  test "account_activation" do
    person = people(:michael)
    person.activation_token = Person.new_token
    mail = PersonMailer.account_activation(person)
    assert_equal "Account activation", mail.subject
    assert_equal [person.email], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match person.first_name, mail.body.encoded
    assert_match person.activation_token, mail.body.encoded
    assert_match CGI.escape(person.email), mail.body.encoded
  end

  test "password_reset" do
    mail = PersonMailer.password_reset
    assert_equal "Password reset", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
