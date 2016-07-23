require 'rails_helper'

RSpec.describe NeighborhoodAnalyst, type: :model do

  before(:each) do
    neighborhood1 = Neighborhood.create(name: "Windsor",
    coordinates: "39.7027778,-104.8847222")
    neighborhood2 = Neighborhood.create(name: "Whittier",
    coordinates: "39.7568611,-104.9663333")
    neighborhood3 = Neighborhood.create(name: "Athmar Park",
    coordinates: "39.7040833,-105.0110000")
    neighborhood4 = Neighborhood.create(name: "Baker",
    coordinates: "39.7156667,-104.9939722")
    neighborhood5 = Neighborhood.create(name: "Barnum",
    coordinates: "39.7181667,-105.0325556")
    neighborhood6 = Neighborhood.create(name: "Auraria",
    coordinates: "39.7461389,-105.0082500")
  end

  it "calculates distance" do
    neighborhood = Neighborhood.create(name: "Windsor", coordinates:
    "39.7027778,-104.8847222")
    user_location = InputAddress.create(address: "1510 Blake Street, Denver, CO")
    expect(NeighborhoodAnalyst.calculate_distance(user_location, neighborhood).round).to eq(7)
  end

  it "calculates duration" do
    Neighborhood.create(name: "Windsor", coordinates:
    "39.7027778,-104.8847222")
    neighborhood = {"Neighborhood" => "Windsor"}
    user_location = InputAddress.create(address: "1510 Blake Street, Denver, CO")
    trans_type = "driving"
    expect(NeighborhoodAnalyst.calculate_duration(user_location, trans_type, neighborhood).round).to be < 40
    expect(NeighborhoodAnalyst.calculate_duration(user_location, trans_type, neighborhood).round).to be > 20
  end

  it "generates neighborhood distance hash" do
    address1 = InputAddress.create(address: "1510 Blake Street, Denver, CO")
    address2 = InputAddress.create(address: "4140 W 38th Ave, Denver, CO")
    address3 = InputAddress.create(address: "Denver Zoo")
    user_addresses = [address1, address2, address3]

    expected_neigh_names = NeighborhoodAnalyst.cumulative_distance_hash(user_addresses).keys
    expect(expected_neigh_names).to eq(["Windsor", "Whittier", "Athmar Park", "Baker", "Barnum", "Auraria"])
    expect(NeighborhoodAnalyst.cumulative_distance_hash(user_addresses)["Whittier"].round).to eq(7)
    expect(NeighborhoodAnalyst.cumulative_distance_hash(user_addresses)["Windsor"].round).to eq(21)
  end

  it "generates neighborhood duration hash" do
    Neighborhood.create(name: "Windsor",
    coordinates: "39.7027778,-104.8847222")
    Neighborhood.create(name: "Whittier",
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
    expect(NeighborhoodAnalyst.cumulative_duration_hash(user_addresses, "driving", top_neighs)["Windsor"].round).to eq(76)
  end

  it "selects top neighborhoods with shortest distances or durations" do
    neigh_hash = {"Whittier" => 10, "Windsor" => 21, "Other1" => 6, "Other2" => 9}
    expect(NeighborhoodAnalyst.select_closest_neighborhoods(2, neigh_hash).count).to eq(2)
    expect(NeighborhoodAnalyst.select_closest_neighborhoods(2, neigh_hash).first["Neighborhood"]).to eq("Other1")
    expect(NeighborhoodAnalyst.select_closest_neighborhoods(2, neigh_hash).first["Distance"]*3).to eq(6)
  end

    it "selects top neighborhoods with shortest distances or durations" do
      neigh_hash = {"Whittier" => 10, "Windsor" => 21, "Other1" => 6, "Other2" => 9}
      expect(NeighborhoodAnalyst.select_closest_neighborhoods(2, neigh_hash).count).to eq(2)
      expect(NeighborhoodAnalyst.select_closest_neighborhoods(2, neigh_hash).first["Neighborhood"]).to eq("Other1")
      expect(NeighborhoodAnalyst.select_closest_neighborhoods(2, neigh_hash).first["Distance"]*3).to eq(6)
    end

    it "selects five neighborhoods with shortest cumululative distance" do

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
<<<<<<< 6fb58db4ae5bae6224dc96c0e9ad64ada4afbdbc
  end
=======

    it "formats the top rent Neighborhoods " do
      n1= Neighborhood.create(name: "lowest", rent: 2400)
      n2= Neighborhood.create(name: "second_lowest", rent: 2401)
      n3= Neighborhood.create(name: "third_lowest", rent: 2402)
      aa = AffordabilityAnalyst.new
      neighborhoods = aa.find_closest_rent_neighborhoods(2400)

      result = NeighborhoodAnalyst.format_top_rent_neighborhoods(neighborhoods)

      expect(result.first).to eq({"Rent" => n3.rent,
       "Neighborhood" => n3.name})


    end
end
>>>>>>> Add top rent neighborhoods
