require "test_helper"

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: 'Agustin', email: 'Agustin@email.com',
                     password: '12341234', password_confirmation: '12341234')
  end

  test 'User should be valid' do
    assert @user.valid?
  end

  test 'Name should be present' do
    assert @user.name = '    '
    assert_not @user.valid?
  end

  test 'Email should be present' do
    assert @user.email = '    '
    assert_not @user.valid?
  end

  test 'Name length should be less than 50' do
    assert @user.name = 'a' * 51
    assert_not @user.valid?
  end

  test 'Email length should be less than 50' do
    assert @user.name = "#{'b' * 51}@email.com"
    assert_not @user.valid?
  end

  test 'Email should have valid format' do
    emails = %w[Agustin@gmail.com 1234@hotmail.jp cocoloco@yahoo.es]
    emails.each do |email|
      @user.email = email
      assert @user.valid?, "#{email} is not valid"
    end
  end

  test 'Email should be unique' do
    @user.save
    duplicate_user = @user.dup
    duplicate_user.email.upcase
    assert_not duplicate_user.save
    @user.destroy
  end

  test 'Email should be saved as lowercase' do
    @user.email = 'EmAil@SupER.cOM'
    @user.save
    assert_equal(@user.email, 'email@super.com')
    @user.destroy
  end

  test 'Password should have a minimum length' do
    @user.password = @user.password_confirmation = 'a'
    assert_not @user.valid?, 'Password is too short'
  end

  test "Password shouldn't be blank" do
    @user.password = @user.password_confirmation = ''
    assert_not @user.valid?, "Password shouldn't be empty"
  end
end
