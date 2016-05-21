class CreateInputAddresses < ActiveRecord::Migration
  def change
    create_table :input_addresses do |t|
      t.string :address
      t.float  :latitude
      t.float  :longitude

      t.timestamps null: false
    end
  end
end
