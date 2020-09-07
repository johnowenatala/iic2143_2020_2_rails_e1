FactoryBot.define do
  factory :model do
    name { Faker::Vehicle.model }
    segment { Model.segments.keys.sample }
    brand { Brand.last || create(:brand) }
  end
end
