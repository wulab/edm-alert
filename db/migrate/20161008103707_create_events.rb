class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.references :location, foreign_key: true
      t.string :title
      t.string :description
      t.string :category
      t.string :source_name
      t.string :source_url
      t.text :source_data
      t.float :longitude
      t.float :latitude
      t.datetime :start_at

      t.timestamps
    end
  end
end
