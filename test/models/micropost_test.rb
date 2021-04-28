require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  def setup
    @user = users(:agustin)
    @microposts = @user.microposts.build(content: 'some content')
  end

  test 'should be valid' do
    assert @microposts.valid?
  end

  test 'should not be valid' do
    @microposts.user_id = nil
    assert_not @microposts.valid?
  end

  test 'content should be present' do
    @microposts.content = '  '
    assert_not @microposts.valid?
  end

  test "length shouldn't be more than 100" do
    @microposts.content = 'a' * 102
    assert_not @microposts.valid?
  end

  test 'order should be the most recent first' do
    assert_equal microposts(:most_recent), Micropost.first
  end
end
