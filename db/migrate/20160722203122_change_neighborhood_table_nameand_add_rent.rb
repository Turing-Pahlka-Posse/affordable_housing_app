class ChangeNeighborhoodTableNameandAddRent < ActiveRecord::Migration
  def change
    rename_table :neighborhood_coordinates, :neighborhoods
  end
end
