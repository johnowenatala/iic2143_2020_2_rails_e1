# app/controllers/years_controller.rb

class YearsController < ClientsController

  before_action :load_year

  def index
    @cars = Car
      .where(year: @year)
      .eager_load(model: :brand)
      .order("brands.name" => :asc, "models.name" => :asc)

    @cars = paginate(@cars)
  end

  def show
    @car = Car.find(params[:id])
  end

  protected

  def load_year
    @year = params[:year].to_i
  end
end