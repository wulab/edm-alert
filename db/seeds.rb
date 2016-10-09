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
    addresses = JSON.load Rails.root.join("db/postal_codes.json")
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

unless User.any?
  say_with_time "seed(\"users\")" do
    User.create!(
      email:     'please-change-me-at-config-initializers-devise@example.com',
      location:  Location.find_by(postal_code: '10260'),
      full_name: 'Default User',
      password:  'passw0rd'
    )
  end
end

unless Event.any?
  say_with_time "seed(\"events\")" do
    location = Location.find_by(postal_code: '10260')
    Event.create!([
      {
        category:    'earthquake',
        latitude:    18.9400000,
        location:    Location.find_by(postal_code: '50250'),
        longitude:   98.7000000,
        source_name: 'กรมอุตุนิยมวิทยา',
        source_url:  'http://data.tmd.go.th/api/DailySeismicEvent/v1/?uid=api&ukey=api12345',
        start_at:    '2016-10-07 20:34:37.000',
        title:       'แผ่นดินไหวที่ อ.สะเมิง จ.เชียงใหม่'
      },
      {
        category:    'flood',
        latitude:    Location.find_by(postal_code: '10260').latitude,
        location:    Location.find_by(postal_code: '10260'),
        longitude:   Location.find_by(postal_code: '10260').longitude,
        source_name: 'สำนักการระบายน้ำ',
        source_url:  'http://203.155.220.119/DDS_Flooding/',
        start_at:    ActiveSupport::TimeZone['Bangkok'].parse('2016-10-08 17:25:00.000'),
        title:       'น้ำท่วมบริเวณ หน้าสถานีรถไฟแบริ่ง'
      }
    ])
  end
end
