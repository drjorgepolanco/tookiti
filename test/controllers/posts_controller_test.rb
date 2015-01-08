require 'test_helper'

class PostsControllerTest < ActionController::TestCase

	def setup
		@post       = posts(:lemur)
		@other_user = users(:jorge)
	end

	test "should redirect create when not logged in" do
		assert_no_difference('Post.count') do
			post :create, post: { title: 'The title', image: 'lemur.jpg'}
		end
		assert_redirected_to(login_url)
	end

	test "should redirect edit when not logged in" do
		get :edit, id: @post
		assert_not flash.empty?
		assert_redirected_to(login_url)
	end

	test "should redirect update when not logged in" do
		patch :update, id: @post, post: { title: @post.title,
		                                  image: @post.image }
		assert_not flash.empty?
		assert_redirected_to(login_url)
	end

	test "should redirect edit when logged in as wrong user" do
		log_in_as(@other_user)
		get :edit, id: @post
		assert flash.empty?
		assert_redirected_to(root_url)
	end

	test "should redirect update when logged in as a wrong user" do
		log_in_as(@other_user)
		patch :update, id: @post, post: { title: @post.title,
		                                  image: @post.image }
		assert flash.empty?
		assert_redirected_to(root_url)
	end
	
	test "should redirect destroy when not logged in" do
		assert_no_difference('Post.count') do
			delete :destroy, id: @post
		end
		assert_redirected_to(login_url)
	end
end