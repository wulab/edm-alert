class CreateHospitals < ActiveRecord::Migration[5.0]
  def change
    create_table :hospitals do |t|
      t.string :name
      t.string :tel
      t.string :address
      t.string :hospital_type
      t.integer :zip_code
      t.integer :area_code

      t.timestamps
    end
  end
end
