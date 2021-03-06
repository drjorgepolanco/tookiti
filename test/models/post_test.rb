require 'test_helper'

class PostTest < ActiveSupport::TestCase

	def setup
		@user = users(:triculito)
		@post = @user.posts.build(user_id: @user.id, title: 'the title',
			                        image: fixture_file_upload('/files/krake.jpg', 'image/jpg'))
	end

	test "should be valid" do
		assert @post.valid?
	end

	test "user id should be present" do
		@post.user_id = nil
		assert_not @post.valid?
	end

	test "title should be present" do
		@post.title = ' '
		assert_not @post.valid?
	end

	test "title should be no longer than 30 characters" do
		@post.title = 'a' * 31
		assert_not @post.valid?
	end

	test "title should be no shorter than 3 characters" do
		@post.title = 'a' * 2
		assert_not @post.valid?
	end

	test "image should be present" do
		@post.image = ' '
		assert_not @post.valid?
	end

	test "order should be must recent first" do
		assert_equal Post.first, posts(:pig)
	end
	
end
