class Location < ApplicationRecord
  has_many :events
  has_many :users

  validates_presence_of :postal_code
end
