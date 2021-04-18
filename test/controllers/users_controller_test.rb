require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:agustin)
    @another_user = users(:catarina)
  end

  test 'should get index' do
    log_in_as(@user)
    get users_url
    assert_response :success
  end

  test 'should get new' do
    get new_user_url
    assert_response :success
  end

  test 'should create user' do
    log_in_as(@user)
    assert_difference('User.count') do
      post users_url, params: { user: {
        name: 'agustino2',
        email: 'agustin.email@something.com',
        password: '12341234',
        password_confirmation: '12341234'
      } }
    end

    assert_redirected_to user_url(User.last)
  end

  test 'should show user' do
    log_in_as(@user)
    get user_url(@user)
    assert_response :success
  end

  test 'should get edit' do
    log_in_as(@user)
    get edit_user_url(@user)
    assert_response :success
  end

  test 'should update user' do
    log_in_as(@user)
    patch user_url(@user), params: { user: {
      name: 'agustino3',
      email: 'agustin.email@something.com',
      password: '12341234',
      password_confirmation: '12341234'
    } }
    assert_redirected_to user_url(@user)
  end

  test 'should destroy user' do
    log_in_as(@user)
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end

  test 'User cannot update another user information' do
    log_in_as(@another_user)
    patch user_url(@user), params: { user: {
      name: 'agustino3',
      email: 'agustin.email@something.com',
      password: '12341234',
      password_confirmation: '12341234'
    } }
    assert_redirected_to root_url
  end
end
