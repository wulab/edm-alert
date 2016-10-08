class Event < ApplicationRecord
  enum category: [ :earthquake, :flood ]
  belongs_to :location
end
