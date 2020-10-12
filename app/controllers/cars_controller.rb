# app/controllers/cars_controller.rb

class CarsController < ClientsController
  def index
    # voy a cargar 24 autos destacados (elegidos al azar entre 200)
    cars = Car.highlighted.limit(200).sample(24)
    # finalmente ordenare los autos en grupos de a 6
    @cars_groups = []
    group = []
    cars.each do |car|
      group << car
      if group.length == 6
        @cars_groups << group
        group = []
      end
    end
    if group.length > 0
      @cars_groups << group
    end
  end

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)

    if @car.save
      redirect_to cars_index_path, notice: 'Auto creado con éxito'
    else
      render :new
    end
  end

  private

  def car_params
    params.require(:car).permit(:model_id, :price)
  end
end
