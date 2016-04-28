class CreateNeighborhoodCoordinates < ActiveRecord::Migration
  def change
    create_table :neighborhood_coordinates do |t|
      t.string :name
      t.string :coordinates

      t.timestamps null: false
    end
  end
end
