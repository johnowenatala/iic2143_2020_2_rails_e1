class Model < ApplicationRecord

  enum segment: {sport: 1, sedan: 2, suv: 3, truck: 4}

  belongs_to :brand, inverse_of: :models
  has_many :cars, inverse_of: :model

  def brand_name
    brand.name
  end

end
