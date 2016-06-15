class InputAddress < ActiveRecord::Base
  geocoded_by :address
  after_validation :geocode

  def build_geojson
    {
      "type": "Feature",
      "geometry": {
        "type": "Point",
        "coordinates": [self.longitude, self.latitude]
      },
      "properties": {
        "title": self.address
      }
    }
  end
end
