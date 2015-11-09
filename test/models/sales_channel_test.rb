require 'test_helper'

class SalesChannelTest < ActiveSupport::TestCase
  test "search finds relevant information" do
    sc1 = SalesChannel.create!(user_id: 1, name: "The Van", description: "Down By thE RiVer")
    sc2 = SalesChannel.create!(user_id: 1, name: "Super Festival", description: "down BY th RIVER")

    #Check that names are searched
    results = SalesChannel.search("Van")
    assert results.include?(sc1)
    refute results.include?(sc2)

    #Check that descriptions are searched and search is case insensitive
    results = SalesChannel.search("river")
    assert results.include?(sc1)
    assert results.include?(sc2)

    results = SalesChannel.search("super")
    refute results.include?(sc1)
    assert results.include?(sc2)
  end
end
