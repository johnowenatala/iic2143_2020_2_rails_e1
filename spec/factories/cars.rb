FactoryBot.define do
  factory :car do
    brand { Faker::Company.industry }
    model { Faker::Superhero.power }
    price { rand(5_000_000 .. 15_000_000) }
  end
end
