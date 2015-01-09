require 'test_helper'

class ContestsControllerTest < ActionController::TestCase
  setup do
    @contest    = contests(:car)
    @user       = users(:triculito)
    @other_user = users(:jorge)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contests)
  end

  test "should get new" do
    log_in_as(@user)
    get :new
    assert_response :success
  end

  test "should create contest" do
    log_in_as(@user)
    assert_difference('Contest.count') do
      post :create, contest: { description: @contest.description, 
                               poll: @contest.poll, poster: @contest.poster, 
                               title: @contest.title }
    end

    assert_redirected_to contest_path(assigns(:contest))
  end

  test "should show contest" do
    get :show, id: @contest
    assert_response :success
  end

  test "should get edit" do
    log_in_as(@user)
    get :edit, id: @contest
    assert_response :success
  end

  test "should update contest" do
    log_in_as(@user)
    patch :update, id: @contest, contest: { description: @contest.description, 
                                            poll: @contest.poll, 
                                            poster: @contest.poster, 
                                            title: @contest.title }
    assert_redirected_to contest_path(assigns(:contest))
  end

  test "should destroy contest" do
    log_in_as(@user)
    assert_difference('Contest.count', -1) do
      delete :destroy, id: @contest
    end

    assert_redirected_to contests_path
  end

  test "should redirect create when not logged in" do
    assert_no_difference('Contest.count') do
      post :create, contest: { title: 'The title', poster: 'lemur.jpg' }
    end
    assert_redirected_to(login_url)
  end

  test "should redirect edit when not logged in" do
    get :edit, id: @contest
    assert_not flash.empty?
    assert_redirected_to(login_url)
  end

  test "should redirect update when not logged in" do
    patch :update, id: @contest, contest: { title:  @contest.title,
                                            poster: @contest.poster }
    assert_not flash.empty?
    assert_redirected_to(login_url)
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get :edit, id: @contest
    assert_not flash.empty?
    assert_redirected_to(root_url)
  end

  test "should redirect update when logged in as a wrong user" do
    log_in_as(@other_user)
    patch :update, id: @contest, contest: { title: @contest.title,
                                            poster: @contest.poster }
    assert_not flash.empty?
    assert_redirected_to(root_url)
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference('Contest.count') do
      delete :destroy, id: @contest
    end
    assert_redirected_to(login_url)
  end

  test "should redirect destroy for wrong contest" do
    log_in_as(@other_user)
    contest = contests(:restaurant)
    assert_no_difference('Contest.count') do
      delete :destroy, id: contest
    end
    assert_redirected_to(root_url)
  end
end
