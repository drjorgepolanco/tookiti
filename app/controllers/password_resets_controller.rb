class PasswordResetsController < ApplicationController
  def new
  end

  def create
  	@user = User.find_by(email: params[:password_reset][:email].downcase)
  	if @user
  		@user.create_reset_digest
  		@user.send_password_reset_email
  		flash[:info] =  'check your email for password reset instructions'
  		redirect_to(root_url)
  	else
  		flash.now[:warning] = 'we could not find your email address'
  		render('new')
  	end
  end

  def edit
  end
end
