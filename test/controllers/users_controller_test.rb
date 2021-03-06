require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    @user     = users(:triculito)
    @user_two = users(:jorge)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to(login_url)
  end

  test "should redirect edit when not logged in" do
    get :edit, id: @user
    assert_not flash.empty?
    assert_redirected_to(login_url) 
  end

  test "should redirect update when not logged in" do
    patch :update, id: @user, user: { first_name: @user.first_name,
                                      last_name:  @user.last_name,
                                      email:      @user.email }
    assert_not flash.empty?
    assert_redirected_to(login_url)
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@user_two)
    get :edit, id: @user
    assert flash.empty?
    assert_redirected_to(root_url)
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@user_two)
    patch :update, id: @user, user: { first_name: @user.first_name,
                                      last_name:  @user.last_name,
                                      email:      @user.email }
    assert flash.empty?
    assert_redirected_to(root_url)
  end

  test "should redirect destroy when the user is not logged in" do
    assert_no_difference('User.count') do
      delete :destroy, id: @user
    end
    assert_redirected_to(login_url)
  end

  test "should redirect destroy when user is logged in but is not admin" do
    log_in_as(@user_two)
    assert_no_difference('User.count') do
      delete :destroy, id: @user
    end
    assert_redirected_to(root_url)
  end

  test "should redirect following when not logged in" do
    get :following, id: @user
    assert_redirected_to(login_url)
  end

  test "should redirect followers when not logged in" do
    get :followers, id: @user
    assert_redirected_to(login_url)
  end

end
