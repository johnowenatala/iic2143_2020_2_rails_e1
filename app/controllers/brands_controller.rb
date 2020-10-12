# app/controllers/brands_controller.rb

class BrandsController < ClientsController

  before_action :load_brand

  def index
    @cars = @brand
      .cars
      .eager_load(model: :brand)
      .order("models.name" => :asc, year: :asc, "cars.id" => :asc)

    @cars = paginate(@cars)
  end

  def show
    @car = @brand.cars.find(params[:id])
  end

  protected

  def load_brand
    @brand = Brand.find_by_name(params[:brand_name])
  end
end