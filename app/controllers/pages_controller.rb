class PagesController < ApplicationController
  def home
  	if logged_in?
  		@user = current_user
  		@users = @user.following
  		@posts = @user.posts
  		@contests = @user.contests
  	end
  end

  def about
  end

  def help
  end

  def contact
  end
end
