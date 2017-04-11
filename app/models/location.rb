class Location < ApplicationRecord
  has_many :events
  has_many :users

  validates_presence_of :postal_code

  def similar_district(district)
    words = Location.all.map(&:district)
    dict = Dictionary.new(words)
    result_district = dict.find_most_similar(district)
    
    Location.find_by(district: result_district)
  end
end
