require 'test_helper'

class MaterialUseTest < ActiveSupport::TestCase
  test "search finds relevant information" do
    project1 = Project.create!(user: users(:one), name: "Cellar Door",
      description: "The most beautiful phrase in the English language")
    mu1 = MaterialUse.create!(project_id: 1, name: "Iron", description: "Used up", units: 50)
    mu2 = MaterialUse.create!(project_id: 1, name: "Wood", description: "It's gone now.", units: 2500)
    pc = MaterialUse.all

    #Check that names are searched
    results = MaterialUse.search(pc, "Cellar")
    assert results.include?(project1)

    #Check that search is case insensitive
    results = MaterialUse.search(pc, "Gone")
    refute results.include?(project1)

    #Check that unfound items don't return results
    results = MaterialUse.search(pc, "West")
    refute results.include?(project1)
  end
end
