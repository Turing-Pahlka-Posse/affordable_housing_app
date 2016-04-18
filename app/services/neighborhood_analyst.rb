class NeighborhoodAnalyst
  def top_three_neighborhoods(addresses, trans_type)
    service = GoogleService.new(addresses.join("").split(",")[0], addresses.join("").split(",")[1], trans_type)
    service.distance
    # ["Globeville", "Five Points", "North Park Hill"]
  end
end
