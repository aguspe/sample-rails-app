require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
  end

  test 'User cannot sign up with invalid data' do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: {
        name: '',
        email: 'agustin.wrongformat',
        password: '12341234',
        password_confirmation: '12341234'
      } }
    end
  end

  test 'User can succesfully sign up' do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: {
        name: 'agustinTest',
        email: 'agustin@email.com',
        password: '12341234',
        password_confirmation: '12341234'
      } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert logged_in?
  end

  test 'valid signup information with account activation' do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: {
        name: 'agustinTest2',
        email: 'agustin2@email.com',
        password: '12341234',
        password_confirmation: '12341234'
      } }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not user.activated?
    log_in_as user
    assert_not logged_in?
    get edit_account_activation_path('Invalid token', email: user.email)
    assert_not logged_in?
    get edit_account_activation_path(user.activation_token, email: 'wrong')
    assert_not logged_in?
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!
    assert_redirected_to root_url
    assert logged_in?
  end
end
