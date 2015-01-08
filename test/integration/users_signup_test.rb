require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

	def setup
		ActionMailer::Base.deliveries.clear
	end

	test "invalid sign up info" do
		get(signup_path)
		assert_no_difference('User.count') do
			post users_path, user: { first_name:            '',
				                       last_name:             'Chikinki',
				                       email: 		            'a.chikinki@mail.com',
				                       password:              'pass',
				                       password_confirmation: 'word' }
		end
		assert_template('users/new')
		assert_select('div.alert-box')
		assert_select('div.field_with_errors')
	end

	test "valid sign up info with account activation" do
		get(signup_path)
		assert_difference('User.count', 1) do
			post users_path, user: { first_name: 'Julito',
				                       last_name:  'Triculi',
				                       email:      'triculito@email.com',
				                       password:              'password',
				                       password_confirmation: 'password' }
	  end
	  assert_equal(1, ActionMailer::Base.deliveries.size)
	  user = assigns(:user)
	  assert_not user.activated?
	  log_in_as(user)
	  assert_not is_logged_in?
	  get edit_account_activation_path('invalid token')
	  assert_not is_logged_in?
	  get edit_account_activation_path(user.activation_token, email: 'wrong')
	  assert_not is_logged_in?
	  get edit_account_activation_path(user.activation_token, email: user.email)
	  assert user.reload.activated?
	  follow_redirect!
	  assert_template('users/show')
	  assert is_logged_in?
	end
end
