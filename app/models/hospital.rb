class Hospital < ApplicationRecord
  validates_presence_of :name, :postal_code

  scope :near_by, -> (postal_code) { where(postal_code: postal_code) }
end
