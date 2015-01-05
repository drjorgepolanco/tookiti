require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:triculito)
	end

	test "unsuccessful edit" do
		log_in_as(@user)
		get edit_user_path(@user)
		assert_template('users/edit')
		patch user_path(@user), user: { first_name: '',
		                                last_name:  '',
		                                email:      'triculito@example.com',
		                                password:   'pass',
		                                password_confirmation:       'word' }
		assert_template('users/edit')
	end

	test "successful edit" do
		log_in_as(@user)
		get edit_user_path(@user)
		assert_template('users/edit')
		first_name = 'Juancito'
		last_name  = 'Trediente'
		email      = 'tredientico@example.com'
		patch user_path(@user), user: { first_name: first_name, 
			                              last_name:  last_name,
			                              email:      email,
			                              password:              '',
			                              password_confirmation: '' }
		assert_not flash.empty?
		assert_redirected_to(@user)
		@user.reload
		assert_equal(@user.first_name,  first_name)
		assert_equal(@user.last_name,   last_name)
		assert_equal(@user.email,       email)
	end
end
