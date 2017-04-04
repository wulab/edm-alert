ActiveAdmin.register User do
  actions :index, :show

  index do
    selectable_column
    id_column
    column :email
    column :full_name
    column :postal_code
    column :district do |obj|
      obj.location.district
    end
    column :province do |obj|
      obj.location.province
    end
    column :disaster do |obj|
      pluralize(obj.location.events.count, 'time')
    end
    column :last_sign_in_at
    column :sign_in_count
    actions
  end

  filter :email
  filter :full_name
  filter :location, as: :select,
          collection: -> { Location.all.map{ |l| [l.postal_code, l.id] } }
end
