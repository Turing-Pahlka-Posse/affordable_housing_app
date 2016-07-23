require 'rails_helper'

RSpec.describe NeighborhoodAnalyst, type: :model do

  it "calculates distance" do
    neighborhood = NeighborhoodCoordinate.create(name: "Windsor", coordinates:
      "39.7027778,-104.8847222")
    user_location = InputAddress.create(address: "1510 Blake Street, Denver, CO")
    expect(NeighborhoodAnalyst.calculate_distance(user_location, neighborhood).round).to eq(7)
  end

  it "calculates duration" do
    NeighborhoodCoordinate.create(name: "Windsor", coordinates:
      "39.7027778,-104.8847222")
    neighborhood = {"Neighborhood" => "Windsor"}
    user_location = InputAddress.create(address: "1510 Blake Street, Denver, CO")
    trans_type = "driving"
    expect(NeighborhoodAnalyst.calculate_duration(user_location, trans_type, neighborhood).round).to be < 40
    expect(NeighborhoodAnalyst.calculate_duration(user_location, trans_type, neighborhood).round).to be > 20
  end

  it "generates neighborhood distance hash" do
    neighborhood1 = NeighborhoodCoordinate.create(name: "Windsor",
      coordinates: "39.7027778,-104.8847222")
    neighborhood2 = NeighborhoodCoordinate.create(name: "Whittier",
      coordinates: "39.7568611,-104.9663333")
    address1 = InputAddress.create(address: "1510 Blake Street, Denver, CO")
    address2 = InputAddress.create(address: "4140 W 38th Ave, Denver, CO")
    address3 = InputAddress.create(address: "Denver Zoo")
    user_addresses = [address1, address2, address3]

    expected_neigh_names = NeighborhoodAnalyst.cumulative_distance_hash(user_addresses).keys

    expect(expected_neigh_names).to eq(["Windsor", "Whittier"])
    expect(NeighborhoodAnalyst.cumulative_distance_hash(user_addresses)["Whittier"].round).to eq(7)
    expect(NeighborhoodAnalyst.cumulative_distance_hash(user_addresses)["Windsor"].round).to eq(21)
  end

  it "generates neighborhood duration hash" do
    NeighborhoodCoordinate.create(name: "Windsor",
      coordinates: "39.7027778,-104.8847222")
    NeighborhoodCoordinate.create(name: "Whittier",
      coordinates: "39.7568611,-104.9663333")
    top_neighs = [{"Neighborhood" => "Windsor", "Distance" => 21},
      {"Neighborhood" => "Whittier", "Distance" => 7}]
    address1 = InputAddress.create(address: "1510 Blake Street, Denver, CO")
    address2 = InputAddress.create(address: "4140 W 38th Ave, Denver, CO")
    address3 = InputAddress.create(address: "Denver Zoo")
    user_addresses = [address1, address2, address3]

    expected_neigh_names = NeighborhoodAnalyst.cumulative_duration_hash(user_addresses, "driving", top_neighs).keys

    expect(expected_neigh_names).to eq(["Windsor", "Whittier"])
    expect(NeighborhoodAnalyst.cumulative_duration_hash(user_addresses, "driving", top_neighs)["Whittier"].round).to eq(34)
    expect(NeighborhoodAnalyst.cumulative_duration_hash(user_addresses, "driving", top_neighs)["Windsor"].round).to eq(77)
  end

  it "selects top neighborhoods with shortest distances or durations" do
    neigh_hash = {"Whittier" => 10, "Windsor" => 21, "Other1" => 6, "Other2" => 9}
    expect(NeighborhoodAnalyst.select_closest_neighborhoods(2, neigh_hash).count).to eq(2)
    expect(NeighborhoodAnalyst.select_closest_neighborhoods(2, neigh_hash).first["Neighborhood"]).to eq("Other1")
    expect(NeighborhoodAnalyst.select_closest_neighborhoods(2, neigh_hash).first["Distance"]*3).to eq(6)
  end

  it "selects five neighborhoods with shortest cumululative distance" do
    neighborhood1 = NeighborhoodCoordinate.create(name: "Windsor",
      coordinates: "39.7027778,-104.8847222")
    neighborhood2 = NeighborhoodCoordinate.create(name: "Whittier",
      coordinates: "39.7568611,-104.9663333")
    neighborhood3 = NeighborhoodCoordinate.create(name: "Athmar Park",
      coordinates: "39.7040833,-105.0110000")
    neighborhood4 = NeighborhoodCoordinate.create(name: "Baker",
      coordinates: "39.7156667,-104.9939722")
    neighborhood5 = NeighborhoodCoordinate.create(name: "Barnum",
      coordinates: "39.7181667,-105.0325556")
    neighborhood6 = NeighborhoodCoordinate.create(name: "Auraria",
      coordinates: "39.7461389,-105.0082500")

    address1 = InputAddress.create(address: "1510 Blake Street, Denver, CO")
    address2 = InputAddress.create(address: "4140 W 38th Ave, Denver, CO")
    address3 = InputAddress.create(address: "Denver Zoo")
    user_addresses = [address1, address2, address3]

    hash = NeighborhoodAnalyst.cumulative_distance_hash(user_addresses)
    first = NeighborhoodAnalyst.select_closest_neighborhoods(5, hash)[0]["Distance"]
    second = NeighborhoodAnalyst.select_closest_neighborhoods(5, hash)[1]["Distance"]
    third = NeighborhoodAnalyst.select_closest_neighborhoods(5, hash)[2]["Distance"]
    fourth = NeighborhoodAnalyst.select_closest_neighborhoods(5, hash)[3]["Distance"]
    fifth = NeighborhoodAnalyst.select_closest_neighborhoods(5, hash)[4]["Distance"]

    expect(NeighborhoodAnalyst.select_closest_neighborhoods(5, hash).count).to eq(5)

    expect(first).to be < second
    expect(second).to be < third
    expect(third).to be < fourth
    expect(fourth).to be < fifth
  end

   pending it "finds top three neighborhoods given 1 address with coordinates" do
     addresses = ["39.7497488,-105.0012001", "39.7497488,-105.0012001", "39.7497488,-105.0012001"]
     trans_type = "driving"
     expect(NeighborhoodAnalyst.top_three_neighborhoods(addresses, trans_type)).to eq(["Auraria", "CBD", "Union Station"])
   end

    pending it "finds top three neighborhoods given 1 address with text" do
      addresses = ["1510 Blake St., Denver, CO"]
      trans_type = "public"

      analyst = NeighborhoodAnalyst.new
      expect(analyst.top_three_neighborhoods(addresses, trans_type)).to eq(["Auraria", "CBD", "Union Station"])
    end

    pending it "finds top three neighborhoods given 1 address with no city or state" do
      addresses = ["1510 Blake Street"]
      trans_type = "public"

      analyst = NeighborhoodAnalyst.new
      expect(analyst.top_three_neighborhoods(addresses, trans_type)).to eq(["Auraria", "CBD", "Union Station"])
    end

    pending it "finds top three neighborhoods given 1 address with text error" do
      addresses = ["1510 Blake Stret"]
      trans_type = "public"

      analyst = NeighborhoodAnalyst.new
      expect(analyst.top_three_neighborhoods(addresses, trans_type)).to eq(["Auraria", "CBD", "Union Station"])
    end

    pending it "finds top three neighborhoods given 3 addresses" do
      addresses = ["1510 Blake St., Denver, CO", "700 W 7th St, Denver, CO", "925 W 9th Ave"]
      trans_type = "public"

      analyst = NeighborhoodAnalyst.new
      expect(analyst.top_three_neighborhoods(addresses, trans_type)).to eq(["Auraria", "CBD", "Union Station"])
    end
end
