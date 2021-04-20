require "test_helper"

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:agustin)
    @user = users(:catarina)
  end

  test 'index includes pagination' do
    log_in_as @user
    get users_path
    assert_template 'users/index'
    assert_select 'nav.pagination'
    User.page(1).each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
    end
  end

  test 'admin can delete users' do
    log_in_as @admin
    get users_path
    assert_template 'users/index'
    User.page(1).each do |user|
      assert_select 'a[href=?]', user_path(user), text: 'delete'
    end
    assert_difference 'User.count', -1 do
      delete user_path(@user)
    end
  end

  test 'non admin cannot delete users' do
    log_in_as @user
    get users_path
    assert_template 'users/index'
    assert_select 'a[href=?]', user_path(user), text: 'delete', count: 0
  end
end
