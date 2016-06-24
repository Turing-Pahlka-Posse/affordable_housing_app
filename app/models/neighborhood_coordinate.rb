class NeighborhoodCoordinate < ActiveRecord::Base

  def latitude
    coordinates.split(',').first.to_f
  end

  def longitude
    coordinates.split(',').last.to_f
  end

end
