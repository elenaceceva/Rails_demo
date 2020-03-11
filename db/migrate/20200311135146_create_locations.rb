class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.float :longitude
      t.float :latitude
      t.string :city
      t.string :country

      t.timestamps
    end
  end
end
