require 'test_helper'

# Some tests pulled from https://www.railstutorial.org/book/modeling_users

class PersonTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @person = Person.new(username: "exper", password: "foobarbaz", password_confirmation: "foobarbaz", first_name: "Example", last_name: "Person", birthday: Date.civil(1994, 1, 1), email: "person@example.com", phone_number: 1505459840)
  end

  test "should be valid" do
    assert @person.valid?
  end

  test "Username should be present" do
    @person.username = "     "
    assert_not @person.valid?
  end

  test "Username should not be too long" do
    @person.username = "a" * 37
    assert_not @person.valid?
  end

  test "Password should be present (nonblank)" do
    @person.password = @person.password_confirmation = " " * 8
    assert_not @person.valid?
  end

  test "Password should have a minimum length" do
    @person.password = @person.password_confirmation = "a" * 7
    assert_not @person.valid?
  end

  test "First name should be present" do
    @person.first_name = "     "
    assert_not @person.valid?
  end

  test "Last name should be present" do
    @person.last_name = "     "
    assert_not @person.valid?
  end

  test "Birthday should be present" do
    @person.birthday = "     "
    assert_not @person.valid?
  end

  test "Email should be present" do
    @person.email = "     "
    assert_not @person.valid?
  end

  test "Email should not be too long" do
    @person.email = "a" * 244 + "@example.com"
    assert_not @person.valid?
  end

  test "Email validation should accept valid addresses" do
    valid_addresses = %w[person@example.com person@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @person.email = valid_address
      assert @person.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "Email validation should reject invalid addresses" do
    invalid_addresses = %w[person@example,com person_at_foo.org person.name@example.foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @person.email = invalid_address
      assert_not @person.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "Email addresses should be unique" do
    duplicate_person = @person.dup
    duplicate_person.email = @person.email.upcase
    @person.save
    assert_not duplicate_person.valid?
  end

  test "Email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @person.email = mixed_case_email
    @person.save
    assert_equal mixed_case_email.downcase, @person.reload.email
  end

  test "Phone number should be present" do
    @person.phone_number = "     "
    assert_not @person.valid?
  end


end
