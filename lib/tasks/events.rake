namespace :events do
  desc "Fetch earthquake events"
  task earthquake: :environment do
    puts "Fetching new earthquake data..."
    EarthquakeDataCollectionJob.perform_later
    puts "done."
  end

  desc "Fetch flood events"
  task flood: :environment do
    puts "Fetching new flood data..."
    FloodDataCollectionJob.perform_later
    puts "done."
  end

end
