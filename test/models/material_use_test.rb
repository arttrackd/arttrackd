require 'test_helper'

class MaterialUseTest < ActiveSupport::TestCase
  # test "search finds relevant information" do
  #   project1 = Project.create!(user: users(:one), name: "Cellar Door",
  #     description: "The most beautiful phrase in the English language")
  #   mp = MaterialPurchase.create!(user_id: 1, name: "Charcoal brush", cost: 200, units: 100, units_remaining: 100)
  #
  #   mu1 = MaterialUse.create!(user_id: 1, project_id: 1, material_purchase_id: mp.id, units: 50)
  #   mu2 = MaterialUse.create!(user_id: 1, project_id: 1, material_purchase_id: mp.id, units: 25)
  #   pc = MaterialUse.all
  #
  #   #Check that names are searched
  #   results = MaterialUse.search(pc, "Cellar")
  #   assert results.include?(project1)
  #
  #   #Check that search is case insensitive
  #   results = MaterialUse.search(pc, "charcoal")
  #   assert results.include?(project1)
  #
  #   #Check that unfound items don't return results
  #   results = MaterialUse.search(pc, "West")
  #   refute results.include?(project1)
  # end
end
