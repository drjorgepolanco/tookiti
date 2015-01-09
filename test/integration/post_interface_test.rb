require 'test_helper'

class PostInterfaceTest < ActionDispatch::IntegrationTest
	def setup
		@user = users(:triculito)
	end

	test "post interface" do
		log_in_as(@user)
		get posts_path
		assert_select('div.post_thumbnail')

		assert_no_difference('Post.count') do
			post posts_path, post: { title: '', image: '' }
		end
		assert_select('div.alert-box')

		title = 'Lorem Ipsum'
		image = fixture_file_upload('/files/krake.jpg', 'image/jpg')
		assert_difference('Post.count', 1) do
			post posts_path, post: { title: title, image: image }
		end
		assert_redirected_to(posts_path)
		follow_redirect!
		assert_match title, response.body

		assert_select('a', text: 'delete')
		first_post = @user.posts.first
		assert_difference('Post.count', -1) do
			delete post_path(first_post)
		end

		get user_path(users(:jorge))
		assert_select('a', text: 'delete', count: 0)
	end

end
