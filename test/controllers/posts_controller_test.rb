require 'test_helper'

class PostsControllerTest < ActionController::TestCase

	def setup
		@post = posts(:lemur)
	end

	test "should redirect create when not logged in" do
		assert_no_difference('Post.count') do
			post :create, post: { title: 'The title', image: 'lemur.jpg'}
		end
		assert_redirected_to(login_url)
	end

	test "should redirect destroy when not logged in" do
		assert_no_difference('Post.count') do
			delete :destroy, id: @post
		end
		assert_redirected_to(login_url)
	end
end
