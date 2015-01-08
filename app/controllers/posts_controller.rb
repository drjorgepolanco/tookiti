class PostsController < ApplicationController
	before_action :logged_in_user, only: [:create, :edit, :update, :destroy]
	before_action :set_post,       only: [:show,   :edit, :update, :destroy]

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
		respond_to do |format|
		  if @post.save
			  format.html do
				  flash[:success] = 'your post was succcessfully created'
				  redirect_to(@post)
			  end
			  format.json { render :show, status: :created, location: @post } 
		  else
			  format.html { render :new }
			  format.json { render json: @post.errors,
			                status: :unprocessable_entity }
		  end
		end
	end

	def edit
	end

	def update
		respond_to do |format|
			if @post.update(post_params)
				format.html do
					flash[:success] = 'your post was succcessfully updated'
					redirect_to(@post)
				end
				format.json { render :show, status: :ok, location: @post }
			else
				format.html { render :edit }
				format.json { render json: @post.errors,
				              status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@post.destroy
		respond_to do |format|
			format.html do
				flash[:success] = 'your post was successfully deleted'
				redirect_to(posts_url)
			end
			format.json { head :no_content }
		end
	end

	private

	  def set_post
	  	@post = Post.find(params[:id])
	  end

	  def post_params
	  	params.require(:post).permit(:title, :image)
	  end
end
