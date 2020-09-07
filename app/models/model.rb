# == Schema Information
#
# Table name: models
#
#  id         :bigint           not null, primary key
#  name       :string
#  segment    :integer          default("sport"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  brand_id   :bigint
#
# Indexes
#
#  index_models_on_brand_id  (brand_id)
#
# Foreign Keys
#
#  fk_rails_...  (brand_id => brands.id)
#
class Model < ApplicationRecord

  enum segment: {sport: 1, sedan: 2, suv: 3, truck: 4}

  belongs_to :brand, inverse_of: :models
  has_many :cars, inverse_of: :model

  def brand_name
    brand.name
  end

end
