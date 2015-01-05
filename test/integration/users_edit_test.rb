require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:triculito)
	end

	test "unsuccessful edit" do
		get edit_user_path(@user)
		assert_template('users/edit')
		patch user_path(@user), user: { first_name: '',
		                                last_name:  '',
		                                email:      'triculito@example.com',
		                                password:   'pass',
		                                password_confirmation:       'word' }
		assert_template('users/edit')
	end
end
