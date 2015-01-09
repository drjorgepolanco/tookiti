class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private

  def logged_in_user
  	unless logged_in?
  		store_location
  		flash[:warning] = 'please, log in'
  		redirect_to(login_url)
  	end
  end

  def correct_user
  	@post = current_user.posts.find_by(id: params[:id])
  	if @post.nil?
  		redirect_to root_url 
  		flash[:warning] = "you can't update or delete somebody else's stuff"
  	end
  end
  
end
