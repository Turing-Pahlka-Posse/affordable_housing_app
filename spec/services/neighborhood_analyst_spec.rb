require 'rails_helper'

RSpec.describe NeighborhoodAnalyst, type: :model do
  pending it "finds top three neighborhoods given 1 address with coordinates" do
    addresses = ["39.7497488,-105.0012001"]
    trans_type = "public"

    analyst = NeighborhoodAnalyst.new
    expect(analyst.top_three_neighborhoods(addresses, trans_type)).to eq(["Auraria", "CBD", "Union Station"])
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
