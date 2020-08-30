class Car < ApplicationRecord

  def brand_and_model
    "#{brand} #{model}"
  end

end
