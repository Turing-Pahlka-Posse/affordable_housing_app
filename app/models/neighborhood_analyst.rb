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

    #goes through the three user input addresses
    #creates nested array of distance between each address and each neighborhood center Points
    #[[dist bw add1 and neigh1, dist bw add1 and neigh2, etc],
    # [dist bw add2 and neigh1, dist bw add2 and neigh2, etc],
    # [dist bw add3 and neigh1, dist bw add3 and neigh2, etc]]
    @addresses.map do |address|
      all_neighborhoods.map do |neighborhood|
        coordinates = neighborhood.coordinates.split(',')
        Haversine.distance(address.latitude, address.longitude, coordinates[0].to_f, coordinates[1].to_f).to_mi
      end
    end
  end

  def self.filter
    #makes array of all neighborhood names; coudld do this with Active Record Instead
    neighborhood_keys = all_neighborhoods.map { |neighborhood| neighborhood.name }
    # denver_neighborhood_names = NeighborhoodCoordinate.pluck(:name)

    # first part makes it into this:
    # [[dist bw add1 and neigh1, dist bw add2 and neigh1, dist bw add2 and neigh1],
    #  [dist bw add1 and neigh2, dist bw add2 and neigh2, dist bw add2 and neigh2], etc through all neighborhoods ]
    # second part consolidates thouse into cumulative distance by neighborhood to each of three addresses
    distance_values = distances[0].zip(distances[1], distances[2]).map { |distance_array| distance_array.reduce :+ }

    #here we now put that information back with the neighborhood name, sort on distance and take top 5
    #this returns the five neighborhood, distance pairs with the lowest distance
    results = Hash[neighborhood_keys.zip(distance_values)].sort_by { |k, v| v }.take(5)


    #now we go through each of those five neighborhoods
    results.map do |neighborhood|
      #finding the AR record for that neighborhood
      neigh = NeighborhoodCoordinate.find_by(name: neighborhood[0])

      #goes through the three user input neighborhoods
      @addresses.map do |address|
        #puts those addresses into lat/long format - is this coming from geocoder?
        loc_1 = "#{address.latitude},#{address.longitude}"
        #this sends info of user coords, neigh coords, and trans to google and gets back a distance or duration - check which one
        @service.distance(loc_1, neigh.coordinates, @trans_type)
      end
      #now we have an array like:
      #[[neigh1 to add1 time, neigh1 to add2 time, neigh1 to add3 time],
      # [neigh2 to add1 time, neigh2 to add2 time, neigh2 to add3 time], etc through 5 neighs]
      #next we are mapping through those and coming up with averge time by neighborhood, which is cumulative time converted to minutes (div by 60) and divided by 3 for three addresses (i.e. div by 180)
      #before the zip we have [neigh1 avg time, neigh 2 avg time, neigh 3 avg time, neigh 4, avg time, neigh 5 avg time]
      #zip pulls neigh names back in becuase we lost them with call to google.
    end.map { |result| (result.reduce :+) / 180 }.zip(results.map do |r|

      r[0]
      #then we sort on distance, take top three
    end).sort.take(3).map do |neighborhood|
      #don't know what's happening here
      Hash[["Distance", "Neighborhood"].zip(neighborhood)]
    end
  end

end
