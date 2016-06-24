class AddRentToNeighborhoodCoordinate < ActiveRecord::Migration
  def change
    add_column :neighborhood_coordinates, :rent, :integer
  end
end
