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

	test "email validation should accept valid addresses" do
		valid_emails = %w[example@mail.com X_YZK-Y2K@mail.example.do 
										  EXAMPLE@mail.COM mike+alisha@example.us one.two@xx.org]
		valid_emails.each do |email|
			@user.email = email
			assert @user.valid?, "#{email.inspect} should be valid"
		end
	end

	test "email validation should reject invalid addresses" do
		invalid_emails = %w[example@mail,com example_.com example@mail. 
											 user@yeah=com.co make@5*5=25 cccd yup@yep+yap.com]
		invalid_emails.each do |email|
			@user.email = email
			assert_not @user.valid?, "#{email.inspect} should not be valid"
		end
	end	
end
