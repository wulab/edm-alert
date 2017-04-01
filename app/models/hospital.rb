class Hospital < ApplicationRecord
  validates_presence_of :name, :postal_code
end
