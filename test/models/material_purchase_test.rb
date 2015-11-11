require 'test_helper'

class MaterialPurchaseTest < ActiveSupport::TestCase
  test "search finds relevant information" do
    mp1 = MaterialPurchase.create!(user_id: 1, name: "Wood", description: "it's wood", cost: 500, units: 30)
    mp2 = MaterialPurchase.create!(user_id: 1, name: "iron", description: "It's iron", cost: 2500, units: 90)

    #Check that names are searched
    results = MaterialPurchase.search("Wood")
    assert results.include?(mp1)
    refute results.include?(mp2)

    #Check that descriptions are searched and search is case insensitive
    results = MaterialPurchase.search("it's")
    assert results.include?(mp1)
    assert results.include?(mp2)

    results = MaterialPurchase.search("Iron")
    refute results.include?(mp1)
    assert results.include?(mp2)
  end
end
