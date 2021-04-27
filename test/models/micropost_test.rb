require "test_helper"

class MicropostTest < ActiveSupport::TestCase
  def setup
    @user = users(:agustin)
    @microposts = Micropost.new(content: 'some content', user_id: @user.id)
  end

  test 'should be valid' do
    assert @microposts.valid?
  end

  test 'should not be valid' do
    @microposts.user_id = nil
    assert_not @microposts.valid?
  end
end
