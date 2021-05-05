require "test_helper"

class RelationshipTest < ActiveSupport::TestCase
  def setup
    @relationship = Relationship.new(follower_id: users(:agustin).id,
                                     followed_id: users(:catarina).id)
  end

  test 'relationship should be valid' do
    assert @relationship.valid?
  end

  test 'should require a follower id' do
    @relationship.follower_id = nil
    assert_not @relationship.valid?
  end

  test 'should require a followed id' do
    @relationship.followed_id = nil
    assert_not @relationship.valid?
  end
end
