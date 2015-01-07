class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :set_user,       only: [:show, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.all
  end

  def show
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      @user.send_activation_email
      flash[:info] = "hi #{@user.first_name}! please, check your email to activate your account"
      redirect_to(root_url)
  	else
  		render('new')
  	end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = 'profile updated'
      redirect_to(@user)
    else
      render('edit')
    end
  end

  def destroy
    @user.destroy
    flash[:success] = 'user deleted'
    redirect_to(users_url)
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

  	def user_params
  		params.require(:user).permit(:first_name, :last_name, :email, :password, 
  																 :password_confirmation)
  	end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:warning] = 'please, log in'
        redirect_to(login_url)
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
