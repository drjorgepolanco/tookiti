class PagesController < ApplicationController
  def home
  	@user = current_user
  	@users = @user.following
  	@posts = @user.posts
  	@contests = @user.contests
  end

  def about
  end

  def help
  end

  def contact
  end
end
