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

  def user_info
    if logged_in?
      @user   ||= current_user
      @users    = @user.following
      @posts    = @user.posts
      @contests = @user.contests
    end
  end
  
end
