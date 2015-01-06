require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

	def setup
		@admin = users(:triculito)
		@user  = users(:jorge)
	end

	test "index as admin should include delete links" do
		log_in_as(@admin)
		get(users_path)
		assert_template('users/index')
		users = User.all
		users.each do |user|
			assert_select('a[href=?]', user_path(user))
			unless user == @admin
				assert_select('a[href=?]', user_path(user), text: 'delete', method: :delete)
			end
		end
		assert_difference('User.count', -1) do
			delete user_path(@user)
		end
	end

	# test "" do
	# end

end
