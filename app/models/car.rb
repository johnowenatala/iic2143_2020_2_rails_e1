# models/car.rb
class Car < ApplicationRecord

  validates :brand, :model, :price, presence: true
  validates :price, numericality: { only_integer: true, greater_than: 5_000_000, less_than: 30_000_000 }

  def brand_and_model
    "#{brand} #{model}"
  end

end
