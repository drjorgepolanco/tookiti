require 'test_helper'

class UserTest < ActiveSupport::TestCase
	def setup
		@user = User.new(first_name: "Name", last_name: "Lastname",
										 email: "user@mail.com")
	end

	test "should be valid" do
		assert @user.valid?
	end

	test "first name should be present" do
		@user.first_name = ""
		assert_not @user.valid?
	end

	test "last name should be present" do
		@user.last_name = ""
		assert_not @user.valid?
	end

	test "email should be present" do
		@user.email = ""
		assert_not @user.valid?
	end

	test "first name should not be too long" do
		@user.first_name = "x" * 31
		assert_not @user.valid?
	end

	test "last name should not be too long" do
		@user.last_name = "x" * 31
		assert_not @user.valid?
	end

	test "email should not be too long" do
		@user.email = "x" * 101
		assert_not @user.valid?
	end	
end
