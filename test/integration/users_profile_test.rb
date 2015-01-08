require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
	include ApplicationHelper

	def setup
		@user = users(:triculito)
	end

	test "profile display" do
		get user_path(@user)
		assert_template('users/show')
		assert_select('title', full_title(full_name(@user)))
		assert_select('h4', text: full_name(@user))
		assert_select('img.gravatar')
		assert_match(@user.posts.count.to_s, response.body)
	end
end
