class PostsController < ApplicationController
	before_action :logged_in_user, only: [:create, :edit, :update, :destroy]
	before_action :set_post,       only: [:show,   :edit, :update, :destroy]
	before_action :correct_user,   only: [:edit, :update, :destroy]

	def show
	end

	def index
		@posts = Post.all
	end

	def new
		@post = Post.new
	end

	def create
		@post = current_user.posts.build(post_params)
		if @post.save
			flash[:success] = 'your post was succcessfully created'
			redirect_to(@post)
		else
			render('new')
		end
	end

	def edit
	end

	def update
		if @post.update_attributes(post_params)
			flash[:success] = 'your post was successfully updated'
			redirect_to(@post)
		else
			render('edit')
		end
	end

	def destroy
		@post.destroy
		flash[:success] = 'your post was successfully deleted'
		redirect_to request.referrer || @posts
	end

	private

	  def set_post
	  	@post = Post.find(params[:id])
	  end

	  def correct_user
	  	@post = current_user.posts.find_by(id: params[:id])
	  	redirect_to root_url if @post.nil?
	  	flash[:warning] = "you can't update or delete somebody else's posts"
	  end

	  def post_params
	  	params.require(:post).permit(:title, :image)
	  end
end
