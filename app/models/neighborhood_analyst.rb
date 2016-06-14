class NeighborhoodAnalyst
  # attr_reader :trans_type, :addresses

  def self.addresses(params)
    address1 = InputAddress.create(address: params["Address_1"])
    address2 = InputAddress.create(address: params["Address_2"])
    address3 = InputAddress.create(address: params["Address_3"])
    @addresses = [address1, address2, address3]
  end

  def self.trans_type(params)
    @trans_type = params["transportation"]
  end

  def self.top_three_neighborhoods(params)
    @service = GoogleService.new
    addresses(params)
    trans_type(params)
    filter
  end

  def self.all_neighborhoods
    NeighborhoodCoordinate.all
  end

  def self.distances
    #Consider result as hash of neighborhood name and distance pairs
    #To eliminate second enumerations through neighborhoods
    @addresses.map do |address|
      all_neighborhoods.map do |neighborhood|
        coordinates = neighborhood.coordinates.split(',')
        Haversine.distance(address.latitude, address.longitude, coordinates[0].to_f, coordinates[1].to_f).to_mi
      end
    end
  end

  def self.filter
    neighborhood_keys = all_neighborhoods.map { |neighborhood| neighborhood.name }
    distance_values = distances[0].zip(distances[1], distances[2]).map { |distance_array| distance_array.reduce :+ }
    results = Hash[neighborhood_keys.zip(distance_values)].sort_by { |k, v| v }.take(5)
    results.map do |neighborhood|
      neigh = NeighborhoodCoordinate.find_by(name: neighborhood[0])
      @addresses.map do |address|
        loc_1 = "#{address.latitude},#{address.longitude}"
        @service.distance(loc_1, neigh.coordinates, @trans_type)
      end
    end.map { |result| (result.reduce :+) / 180 }.zip(results.map do |r|
      r[0]
    end).sort.take(3).map do |neighborhood|
      Hash[["Distance", "Neighborhood"].zip(neighborhood)]
    end
  end

end
