# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
def say(message, subitem = false)
  puts "#{subitem ? '   ->' : '--'} #{message}"
end

def say_with_time(message)
  say message
  result = nil
  time = Benchmark.measure { result = yield }
  say "%.4fs" % time.real, :subitem
  result
end

unless Location.any?
  say_with_time "seed(\"locations\")" do
    addresses = JSON.load Rails.root.join("db/addresses.json")
    addresses.each do |address|
      Location.create!(
        district:    address['district'],
        latitude:    address['lat'],
        longitude:   address['lng'],
        postal_code: address['zip'],
        province:    address['province']
      )
    end
  end
end

unless Event.any?
  say_with_time "seed(\"events\")" do
    Event.create(location: Location.find_by(postal_code: '10400'),
          title: 'แผ่นดินไหวที่ อ.สะเมิง จ.เชียงใหม่',
          description: '',
          category: 'แผ่นดินไหว',
          source_name: 'Thai Meteorological Department:2558',
          source_url: 'http://data.tmd.go.th/',
          source_data: '',
          longitude: 98.7000000,
          latitude: 18.9400000,
          start_at: Time.now)
  end
end
