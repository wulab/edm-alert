class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.string :district
      t.string :province
      t.string :postal_code
      t.float :longitude
      t.float :latitude

      t.timestamps
    end
  end
end
