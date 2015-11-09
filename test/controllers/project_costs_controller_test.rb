require 'test_helper'

class ProjectCostsControllerTest < ActionController::TestCase
  setup do
    @project_cost = project_costs(:one)
    @user = users(:one)
    session[:user_id] = @user.id
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:projects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project_cost" do
    assert_difference('ProjectCost.count') do
      post :create, project_cost: { amount: @project_cost.amount, cost_type: @project_cost.cost_type, project_id: @project_cost.project_id }
    end

    assert_redirected_to project_cost_path(assigns(:project_cost))
  end

  test "should show project_cost" do
    get :show, id: @project_cost
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @project_cost
    assert_response :success
  end

  test "should update project_cost" do
    patch :update, id: @project_cost, project_cost: { amount: @project_cost.amount, cost_type: @project_cost.cost_type, project_id: @project_cost.project_id }
    assert_redirected_to project_cost_path(assigns(:project_cost))
  end

  test "should destroy project_cost" do
    assert_difference('ProjectCost.count', -1) do
      delete :destroy, id: @project_cost
    end

    assert_redirected_to project_costs_path
  end
end
