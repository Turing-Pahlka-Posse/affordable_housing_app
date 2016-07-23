require 'csv'

namespace :import do

  desc "import rent data from csv"
  task rent: :environment do
    filename = File.join Rails.root, "data/zillow_rent_data.csv"
    CSV.foreach(filename, headers: true) do |row|
      next if row["City"] != "Denver"
      if Neighborhood.find_by(name: row["RegionName"])
        neighborhood = Neighborhood.find_by(name: row["RegionName"]) 
      else
        next
      end
      neighborhood.update_attributes(rent: row["Zri"])
    end
  end
end
