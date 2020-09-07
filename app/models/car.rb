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
