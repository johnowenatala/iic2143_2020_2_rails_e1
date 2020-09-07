FactoryBot.define do
  factory :store do
    name { Faker::Company.name }
    address { Faker::Address.full_address }
  end
end
