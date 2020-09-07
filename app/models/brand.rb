class Brand < ApplicationRecord
  has_many :models, inverse_of: :brand

  validates :name, uniqueness: true
end
