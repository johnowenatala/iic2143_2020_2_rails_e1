class MoveCarsDataToModelAndBrandModels < ActiveRecord::Migration[5.2]
  def up
    Car.all.each do |car|
      brand = Brand.where(name: car.old_brand).first_or_create
      model = brand.models.where(name: car.old_model).first_or_create
      car.model = model
      car.save!
    end
  end

  def down
    Car.all.each do |car|
      car.update(
        old_model: car.car_model_name,
        old_brand: car.brand_name
      )
    end
  end
end
