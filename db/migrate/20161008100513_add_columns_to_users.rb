class AddColumnsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :location, foreign_key: true
    add_column :users, :full_name, :string
    add_column :users, :longitude, :float
    add_column :users, :latitude, :float
    add_column :users, :notified_at, :datetime
  end
end
