require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
	test "invalid signup info" do
		get signup_path
		assert_no_difference('User.count') do
			post users_path, user: { first_name:            '',
                               last_name:             'Chikinki',
                               email: 		            'a.chikinki@mail.com',
                               password:              'pass',
                               password_confirmation: 'word' }
		end
		assert_template 'users/new'
		assert_select 'div.alert-box'
	end

	test "valid signup info" do
		get signup_path
		assert_difference('User.count', 1) do
			post_via_redirect users_path, user: { first_name: 'Julito',
                                            last_name:  'Triculi',
                                            email:      'triculito@email.com',
                                            password:              'password',
                                            password_confirmation: 'password' }
		end
		assert_template 'users/show'
		assert_not flash.empty?
	end
end
