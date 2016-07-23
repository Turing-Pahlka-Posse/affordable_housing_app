class AddRenttoNeighborhood < ActiveRecord::Migration
  def change
    add_column :neighborhoods, :rent, :integer
  end
end
