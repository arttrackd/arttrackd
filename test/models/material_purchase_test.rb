require 'test_helper'

class MaterialPurchaseTest < ActiveSupport::TestCase
  test "search finds relevant information" do
    mp1 = MaterialPurchase.create!(user_id: 1, name: "Wood", cost: 500, units: 30)
    mp2 = MaterialPurchase.create!(user_id: 1, name: "iron", cost: 2500, units: 90)

    #Check that names are searched
    results = MaterialPurchase.search("Wood")
    assert results.include?(mp1)
    refute results.include?(mp2)

    #Check that descriptions are searched and search is case insensitive

    results = MaterialPurchase.search("Iron")
    refute results.include?(mp1)
    assert results.include?(mp2)
  end

  test ""
end
