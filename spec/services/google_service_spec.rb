require 'rails_helper'

RSpec.describe GoogleService, type: :service do
  pending it "retrieves time to travel between 2 points" do
    address_1 = "39.7060556,-104.9498889"
    address_2 = "39.7497488,-105.0012001"
    trans_type = "public"

    service = GoogleService.new
    expect(service.distance(address_1, address_2, trans_type)).to eq(58)
  end
end
