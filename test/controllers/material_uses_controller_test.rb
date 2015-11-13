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

  test "should create material_use" do
    mp = MaterialPurchase.create!(user_id: 1, name: "Charcoal brush", cost: 200, units: 100, units_remaining: 100)
    assert_difference('MaterialUse.count') do
      post :create, material_use: { user_id: 1, material_purchase_id: mp.id, project_id: 1, units: 1 }
    end

    assert_redirected_to material_use_path(assigns(:material_use))
  end

  test "should update material_use" do
    mp = MaterialPurchase.create!(user_id: 1, name: "Charcoal brush", cost: 200, units: 100, units_remaining: 100)
    patch :update, id: @material_use, material_use: {  material_purchase_id: mp.id, project_id: @material_use.project_id, units: @material_use.units }
    assert_redirected_to material_use_path(assigns(:material_use))
  end

  test "should destroy material_use" do
    assert_difference('MaterialUse.count', -1) do
      delete :destroy, id: @material_use
    end

    assert_redirected_to material_uses_path
  end
end
