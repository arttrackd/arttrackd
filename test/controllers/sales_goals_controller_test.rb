require 'test_helper'

class SalesGoalsControllerTest < ActionController::TestCase
  setup do
    @sales_goal = sales_goals(:one)
    @user = users(:one)
    session[:user_id] = @user.id
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_nil assigns(:sales_goals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sales_goal" do
    assert_difference('SalesGoal.count') do
      post :create, sales_goal: { amount: 1000, length_of_time: @sales_goal.length_of_time, start_time: @sales_goal.start_time, success: @sales_goal.success, user_id: @sales_goal.user_id }
    end

    assert_redirected_to sales_goal_path(assigns(:sales_goal))
  end

  test "should show sales_goal" do
    get :show, id: @sales_goal
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sales_goal
    assert_response :success
  end

  test "should update sales_goal" do
    patch :update, id: @sales_goal, sales_goal: { amount: @sales_goal.amount, length_of_time: @sales_goal.length_of_time, start_time: @sales_goal.start_time, success: @sales_goal.success, user_id: @sales_goal.user_id }
    assert_redirected_to sales_goal_path(assigns(:sales_goal))
  end

  test "should destroy sales_goal" do
    assert_difference('SalesGoal.count', -1) do
      delete :destroy, id: @sales_goal
    end

    assert_redirected_to sales_goals_path
  end
end
