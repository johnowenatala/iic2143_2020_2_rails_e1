FactoryBot.define do
  factory :brand do
    name { Faker::Vehicle.make }
  end
end
