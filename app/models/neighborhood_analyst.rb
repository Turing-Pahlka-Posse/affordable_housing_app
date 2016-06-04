class NeighborhoodAnalyst
  def self.top_three_neighborhoods(params)
    service = GoogleService.new

    address1 = InputAddress.create(address: params["Address 1"])
    address2 = InputAddress.create(address: params["Address 2"])
    address3 = InputAddress.create(address: params["Address 3"])
    trans_type = params["transportation"]
    addresses = [address1, address2, address3]

    all_neighborhoods = NeighborhoodCoordinate.all
    distances = addresses.map do |address|
      all_neighborhoods.map do |neighborhood|
        coordinates = neighborhood.coordinates.split(',')
        Haversine.distance(address.latitude, address.longitude, coordinates[0].to_f, coordinates[1].to_f).to_mi
      end
    end
    neighborhood_keys = all_neighborhoods.map { |neighborhood| neighborhood.name }
    distance_values = distances[0].zip(distances[1], distances[2]).map { |distance_array| distance_array.reduce :+ }
    results = Hash[neighborhood_keys.zip(distance_values)].sort_by { |k, v| v }.take(5)
    results.map do |neighborhood|
      neigh = NeighborhoodCoordinate.find_by(name: neighborhood[0])
      addresses.map do |address|
        loc_1 = "#{address.latitude},#{address.longitude}"
        service.distance(loc_1, neigh.coordinates, trans_type)
      end
    end.map { |result| (result.reduce :+) / 180 }.zip(results.map do |r|
      r[0]
    end).sort.take(3).map do |neighborhood|
      Hash[["Distance", "Neighborhood"].zip(neighborhood)]
    end
  end
end
