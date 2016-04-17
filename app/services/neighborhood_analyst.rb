class NeighborhoodAnalyst
  def top_three_neighborhoods
    service = GoogleService.new
    service.distance
    # ["Globeville", "Five Points", "North Park Hill"]
  end
end
