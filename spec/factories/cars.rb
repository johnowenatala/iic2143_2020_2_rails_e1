FactoryBot.define do
  factory :car do
    model { Model.last || create(:model) }
    price { rand(5_000_000 .. 15_000_000) }
  end
end
