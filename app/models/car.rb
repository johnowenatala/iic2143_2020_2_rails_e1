# models/car.rb
class Car < ApplicationRecord

  belongs_to :model, inverse_of: :cars
  has_one :brand, through: :model

  validates :brand, :model, :price, presence: true
  validates :price, numericality: { only_integer: true, greater_than: 5_000_000, less_than: 30_000_000 }

  def brand_name
    brand.name
  end

  def car_model_name
    model.name
  end

  def brand_and_model
    "#{brand_name} #{car_model_name}"
  end

end
