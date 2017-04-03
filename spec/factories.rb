FactoryGirl.define do
  factory :user do
    email     Faker::Internet.email
    password  'password'
    full_name Faker::Name.name
  end

  factory :location do
    district    Faker::Address.city
    province    Faker::Address.country
    postal_code Faker::Address.postcode
    longitude   Faker::Address.longitude
    latitude    Faker::Address.latitude
  end

  factory :event do
    title       Faker::Name.name
    description Faker::Name.name
    source_url  Faker::Internet.url
    start_at    Time.now
  end
end
