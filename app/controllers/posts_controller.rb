class PostsController < ApplicationController
	before_action :logged_in_user, only: [:create, :edit, :update, :destroy]
	before_action :set_post,       only: [:show]

	def show
	end

	def index
	end

	def new
		@post = Post.new
	end

	def create
		@post = current_user.posts.build(post_params)
		if @post.save
			flash[:success] = 'post created!'
			redirect_to(root_url)
		else
			render('posts/new')
		end
	end

	def edit
	end

	def update
	end

	def destroy
	end

	private

	  def set_post
	  	@post = Post.find(params[:id])
	  end

	  def post_params
	  	params.require(:post).permit(:title, :image)
	  end
end
