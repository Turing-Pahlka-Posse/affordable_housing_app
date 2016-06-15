class InputAddress < ActiveRecord::Base
  geocoded_by :address
  after_validation :geocode

  def build_geojson
    {
      "type": "Feature",
      "geometry": {
        "type": "Point",
        "coordinates": [self.latitude, self.longitude]
      },
      "properties": {
        "Title": self.address,
      }
    }
  end
end
