require 'test_helper'

class MaterialUsesControllerTest < ActionController::TestCase
  setup do
    @project = projects(:one)
    @material_purchase = material_purchases(:one)
    @material_use = material_uses(:one)
    @current_user = users(:one)
    @material_use.user_id = @current_user.id
    @material_use.save
    session[:user_id] = @current_user.id
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

  test "should create material_use" do
    assert_difference('MaterialUse.count') do
      post :create, material_use: { material_purchase_id: 1, name: @material_use.name, project_id: 1, units: 1 }
    end

    assert_redirected_to material_use_path(assigns(:material_use))
  end

  test "should show material_use" do
    get :show, id: @material_use
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @material_use
    assert_response :success
  end

  test "should update material_use" do
    patch :update, id: @material_use, material_use: { description: @material_use.description, material_purchase_id: @material_use.material_purchase_id, name: @material_use.name, project_id: @material_use.project_id, units: @material_use.units }
    assert_redirected_to material_use_path(assigns(:material_use))
  end

  test "should destroy material_use" do
    assert_difference('MaterialUse.count', -1) do
      delete :destroy, id: @material_use
    end

    assert_redirected_to material_uses_path
  end
end
