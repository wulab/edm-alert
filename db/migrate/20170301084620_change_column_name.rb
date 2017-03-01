class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :hospitals, :zip_code, :postal_code
  end
end
