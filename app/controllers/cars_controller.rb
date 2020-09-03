# app/controllers/cars_controller.rb

class CarsController < ApplicationController
  def index
    @cars = Car.all
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
    params.require(:car).permit(:brand, :model, :price)
  end
end
