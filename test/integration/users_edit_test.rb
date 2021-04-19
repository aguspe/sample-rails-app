require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:agustin)
  end

  test 'failed update' do
    log_in_as @user
    get edit_user_path @user
    assert_template 'users/edit'
    patch user_path(@user), params: { user: {
      name: '',
      email: 'failed',
      password: 'hello',
      password_confirmation: 'bye'
    } }
    assert_template 'users/edit'
  end

  test 'successful update with friendly fowarding' do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = 'Agustin1'
    email = 'agustin1@test.com'
    patch user_path(@user), params: { user: {
      name: 'Agustin1',
      email: 'agustin1@test.com',
      password: 'hello1',
      password_confirmation: 'hello1'
    } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end
end
