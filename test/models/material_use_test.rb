require 'test_helper'

class MaterialUseTest < ActiveSupport::TestCase
  test "search finds relevant information" do
    mu1 = MaterialUse.create!(name: "Iron", description: "Used up", units: 50)
    mu2 = MaterialUse.create!(name: "Wood", description: "It's gone now.", units: 2500)
    pc = MaterialUse.all

    #Check that names are searched
    results = MaterialUse.search("Iron")
    assert results.include?(mu1)
    refute results.include?(mu2)

    #Check that search is case insensitive
    results = MaterialUse.search("Gone")
    refute results.include?(mu1)
    assert results.include?(mu2)

    #Check that unfound items don't return results
    results = MaterialUse.search("West")
    refute results.include?(mu1)
    refute results.include?(mu2)
  end
end
