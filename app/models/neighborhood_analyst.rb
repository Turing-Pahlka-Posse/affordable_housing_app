class NeighborhoodAnalyst

  def self.user_addresses(params)
    address1 = InputAddress.create(address: params["Address_1"])
    address2 = InputAddress.create(address: params["Address_2"])
    address3 = InputAddress.create(address: params["Address_3"])
    [address1, address2, address3]
  end

  def self.trans_type(params)
    params["transportation"]
  end

  def self.top_three_neighborhoods(params)
    all_distances = cumulative_distance_hash(user_addresses(params))
    closest_distances = select_closest_neighborhoods(5, all_distances)
    durations = cumulative_duration_hash(user_addresses(params),
      trans_type(params), closest_distances)
    select_closest_neighborhoods(3, durations)
  end

  def self.calculate_distance(user_location, neighborhood)
    Haversine.distance(user_location.latitude, user_location.longitude,
      neighborhood.latitude, neighborhood.longitude).to_mi
  end

  def self.calculate_duration(user_loc, trans_type, neigh)
    service = GoogleService.new
    neigh = NeighborhoodCoordinate.find_by(name: neigh["Neighborhood"])
    service.duration(user_loc.coordinates, neigh.coordinates, trans_type)/60.0
  end

  def self.cumulative_distance_hash(user_addresses)
    NeighborhoodCoordinate.all.reduce({}) do |distance_hash, neighborhood|
      distance_hash[neighborhood.name] =
        user_addresses.reduce(0) do |cumulative_distance, address|
          cumulative_distance += calculate_distance(address, neighborhood)
        end
      distance_hash
    end
  end

  def self.cumulative_duration_hash(user_addresses, trans_type, top_neighs)
    top_neighs.reduce({}) do |duration_hash, neighborhood|
      duration_hash[neighborhood["Neighborhood"]] =
        user_addresses.reduce(0) do |total_duration, address|
          total_duration += calculate_duration(address, trans_type, neighborhood)
        end
      duration_hash
    end
  end

  def self.select_closest_neighborhoods(num_neigh, neigh_hash)
    sorted = neigh_hash.sort_by {|name, dist| dist}.take(num_neigh)
    format_top_neighborhoods(sorted)
  end

  def self.format_top_neighborhoods(sorted_neighborhoods, num_addresses=3)
    sorted_neighborhoods.map do |neigh_distance_pair|
      {"Distance" => (neigh_distance_pair[1]/num_addresses).round(2),
       "Neighborhood" => neigh_distance_pair[0]}
    end
  end

end
