# == Schema Information
#
# Table name: cars
#
#  id           :bigint           not null, primary key
#  description  :string
#  price        :integer
#  transmission :integer          default("manual"), not null
#  year         :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  model_id     :bigint
#
# Indexes
#
#  index_cars_on_model_id  (model_id)
#
# Foreign Keys
#
#  fk_rails_...  (model_id => models.id)
#
class Car < ApplicationRecord

  enum transmission: { manual: 1, auto: 2, other: 3 }, _prefix: true

  belongs_to :model, inverse_of: :cars
  has_one :brand, through: :model
  has_and_belongs_to_many :stores

  validates :brand, :model, :price, presence: true
  validates :price, numericality: { only_integer: true, greater_than: 5_000_000, less_than: 30_000_000 }

  scope :old, -> { where("year < ?", Date.today.year - 5) }
  scope :most_expensive_first, -> { order(price: :desc) }

  def self.expensive
    # necesito saber cuantos autos hay para saber donde esta el 30% mas caro
    total = Car.all.count
    limit_30_percent_nth = (total * 0.3).to_i # este es el elemento correspondiente al 30%
    limit_30_value = Car
      .order(price: :desc)
      .limit(1)
      .offset(limit_30_percent_nth)
      .pluck(:price)
      .first # este es el 30% mas caro
    # por ultimo, completamos este scope
    where("price >= ?", limit_30_value )
  end

  def self.highlighted
    # un auto es destacado si es anterior a los ultimos 5 años
    # y es del 30% mas caro
    old.expensive
  end

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
