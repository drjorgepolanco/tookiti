require 'test_helper'

class ContestTest < ActiveSupport::TestCase

	def setup
		@user = users(:triculito)
		@contest = @user.contests.build(user_id: @user.id, title: 'the title',
			                              poster: fixture_file_upload('/files/finally.jpg', 
			                              'image/jpg'))
	end

	test "should be valid" do
		assert @contest.valid?
	end

	test "user id should be present" do
		@contest.user_id = nil
		assert_not @contest.valid?
	end

	test "title should be present" do
		@contest.title = ' '
		assert_not @contest.valid?
	end

	test "title should be no longer than 30 characters" do
		@contest.title = 'a' * 31
		assert_not @contest.valid?
	end

	test "title should be no shorter than 3 characters" do
		@contest.title = 'a' * 2
		assert_not @contest.valid?
	end

	test "poster should be present" do
		@contest.poster = ' '
		assert_not @contest.valid?
	end

	test "order should be must recent first" do
		assert_equal Contest.first, contests(:restaurant)
	end

end
