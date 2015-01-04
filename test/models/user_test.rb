require 'test_helper'

class UserTest < ActiveSupport::TestCase
	def setup
		@user = User.new(first_name: "Name", last_name: "Lastname",
										 email: "user@mail.com")
	end

	test "should be valid" do
		assert @user.valid?
	end
end
