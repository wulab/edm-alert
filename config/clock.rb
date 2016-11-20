require 'clockwork'
require './config/boot'
require './config/environment'

module Clockwork
  handler do |job|
    job.constantize.perform_later
  end

  every(1.day, 'EarthquakeDataCollectionJob')
  every(1.day, 'FloodDataCollectionJob')

  # note: callbacks that return nil or false will cause event to not run
  # on(:before_tick) do
  #   puts "tick"
  #   true
  # end

  # on(:after_tick) do
  #   puts "tock"
  #   true
  # end
end
