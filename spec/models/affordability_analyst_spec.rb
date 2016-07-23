require 'rails_helper'

RSpec.describe AffordabilityAnalyst, type: :model do

  it "identifies three closest rent neighborhoods" do
    n1= Neighborhood.create(name: "closest", rent: 2400)
    n2= Neighborhood.create(name: "second_closest", rent: 2399)
    n3= Neighborhood.create(name: "third_closest", rent: 2398)
    n4= Neighborhood.create(name: "not_closest", rent: 2397)

    aa = AffordabilityAnalyst.new
    results = aa.find_closest_rent_neighborhoods(2000)
    expect(results.count).to eq(3)
    expect(results.first.class).to eq(Neighborhood)
    expect(results.pluck(:name)).to eq(["closest", "second_closest", "third_closest"])
  end

  it "identifies three lowest rent neighborhoods when max rent too low" do
    n1= Neighborhood.create(name: "lowest", rent: 2400)
    n2= Neighborhood.create(name: "second_lowest", rent: 2401)
    n3= Neighborhood.create(name: "third_lowest", rent: 2402)
    n4= Neighborhood.create(name: "not_closest", rent: 2403)

    aa = AffordabilityAnalyst.new
    results = aa.find_closest_rent_neighborhoods(500)
    expect(results.count).to eq(3)
    expect(results.first.class).to eq(Neighborhood)
    expect(results.pluck(:name)).to eq(["lowest", "second_lowest", "third_lowest"])
  end

end
