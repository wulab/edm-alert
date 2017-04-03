ActiveAdmin.register User do
  index do
    selectable_column
    id_column
    column :email
    column :full_name
    column :postal_code
    column :last_sign_in_at
    column :sign_in_count
    actions
  end

  filter :email
  filter :full_name
end
