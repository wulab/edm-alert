FactoryGirl.define do
  factory :user do
    email Faker::Internet.email
    full_name Faker::Name.name
  end
end
