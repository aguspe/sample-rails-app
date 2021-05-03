require "test_helper"

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:agustin)
  end

  test 'micropost invalid submission' do
    log_in_as @user
    get root_path
    assert_no_difference 'Micropost.count' do
      post microposts_path, params: { micropost: { content: '' } }
    end
    assert_select 'div#error_explanation'
  end

  test 'miropost valid submission' do
    log_in_as @user
    get root_path
    assert_difference 'Micropost.count', 1 do
      post microposts_path, params: { micropost: { content: 'hello' } }
    end
  end

  test 'delete a micropost' do
    log_in_as @user
    get root_path
    assert_select 'a', text: 'delete'
    assert_difference 'Micropost.count', -1 do
      delete microposts_path(microposts(@user.microposts.first))
    end
  end
end
