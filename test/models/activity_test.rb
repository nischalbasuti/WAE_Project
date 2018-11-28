require 'test_helper'

class ActivityTest < ActiveSupport::TestCase

	test "should validate dates" do
		@activity1 = activities[:one]
		assert_operator @activity1.end_time, :>=, @activity1.end_time
	end
  # test "the truth" do
  #   assert true
  # end
end
