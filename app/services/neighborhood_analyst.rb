class NeighborhoodAnalyst
  def top_three_neighborhoods(addresses, trans_type)
    service = GoogleService.new

    user_address = addresses[0]

    all_neighborhoods = NeighborhoodCoordinate.all

    list_of_distances = all_neighborhoods.map do |neighborhood|
      [neighborhood.name, service.distance(user_address, neighborhood.coordinates, trans_type)]
    end

    binding.pry

    #
    # addresses.map do |address|
    #   service.distance(address, trans_type)
    # end
    #
    # service = GoogleService.new
    # service.distance(addresses[0], trans_type)
    # ["Globeville", "Five Points", "North Park Hill"]
  end

  # get address array
  # on each address, call service for each neighborhood
  # put data from each call into new array


end


