require 'shoulda/matchers'

FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    user_name { Faker::Internet.user_name }
    email { Faker::Internet.email }
    password "foobar123"
    type "Good Samaritan"
    street_address { Faker::Address.street_address }
    city { Faker::Address.city }
    state_address "NY"
    zip 1
  end

end
