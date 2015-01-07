class PasswordResetsController < ApplicationController
  before_action :get_user,         only: [:edit, :update]
  before_action :valid_user,       only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

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
  		flash.now[:warning] = "sorry, we couldn't find your email address"
  		render('new')
  	end
  end

  def edit
  end

  def update
    if both_passwords_blank?
      flash.now[:warning] = "sorry, the password/confirmation can't be blank"
      render('edit')
    elsif @user.update_attributes(user_params)
      log_in @user
      flash[:success] = 'your password has been reset'
      redirect_to(@user)
    else
      render('edit')
    end
  end

  private

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def both_passwords_blank?
      params[:user][:password].blank? and
      params[:user][:password_confirmation].blank?
    end

    def get_user
      @user = User.find_by(email: params[:email])
    end

    def valid_user
      unless (@user and @user.activated? and @user.authenticated?(:reset, params[:id]))
      redirect_to(root_url)
    end

    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = 'your password reset has expired'
        redirect_to(new_password_reset_url)
      end
    end
  end
end
