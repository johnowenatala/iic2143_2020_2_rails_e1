
class ClientsController < ApplicationController

  def index
    @brands = Brand.all
    @years = Car.all.order(year: :desc).distinct(:year).limit(7).pluck(:year)

    # en el home vamos a poner 24 autos destacados
    # un auto es destacado segun si tiene un precio "destacable" (segun la tienda)
    @cars = Car
      .joins(:stores)
      .where("price > :regular_price OR (stores.name IN (:low_price_stores) AND price > :low_price)",
        regular_price: 25_000_000,
        low_price_stores: ['Wintheiser, Kunde and Orn', 'Johns Group'],
        low_price: 20_000_000
      )
      .limit(100)
      .distinct
    # De estos 100 autos, vamos a sacar 24 al azar
    @cars = @cars.sample(24)

    # vamos a destacar los 6 autos mas caros de los "antiguos"
    # (un auto es antiguo si es anterior a 5 años)
    # primero vamos a dejas los autos antiguos
    @highlights = @cars.select do |car|
      car.year < (Date.today.year - 5)
    end
    # si hay menos de 6, vamos a meter los 6 primeros que no esten ya
    if @highlights.length < 6
      @highlights += @cars.reject{|c| @highlights.include?(c) }.first(6)
    end
    # ahora ordenamos por precio (negativo, para que queden primero los mayores)
    @highlights = @highlights.sort_by{|car| -car.price}
    # dejamos los 6 primeros
    @highlights = @highlights.first(6)

    # finalmente ordenare los autos en grupos de a 6
    @cars_groups = []
    group = []
    @cars.each_with_index do |car, index|
      if index > 0 && index % 6 == 0
        @cars_groups << group
        group = []
      end
      group << car
    end
    @cars_groups << group

  end

  def brand
    @brands = Brand.all
    @years = Car.all.order(year: :desc).distinct(:year).limit(7).pluck(:year)

    @brand = Brand.where(name: params[:brand_name]).first
    @cars = Car
      .eager_load(model: :brand)
      .where(brands: {name: params[:brand_name]})
      .order("models.name" => :asc, year: :asc, "cars.id" => :asc)

    all_cars = @cars

    # paginacion
    @page = params[:page].to_i
    @page = 1 if @page <= 0
    @pages = (@cars.count / 10.0).ceil
    @cars = @cars.limit(10).offset((@page - 1) * 10).to_a

    # vamos a destacar los 10 autos de los "antiguos"
    # (un auto es antiguo si es anterior a 5 años)
    # primero vamos a dejas los autos antiguos
    @highlights = all_cars.select do |car|
      car.year < (Date.today.year - 5)
    end
    # si hay menos de 10, vamos a meter los 10 primeros que no esten ya
    if @highlights.length < 10
      @highlights += all_cars.reject{|c| @highlights.include?(c) }.first(10)
    end
    # dejamos los 10 primeros
    @highlights = @highlights.first(10)

  end

  def year
    @brands = Brand.all
    @years = Car.all.order(year: :desc).distinct(:year).limit(7).pluck(:year)

    @year = params[:year]
    @cars = Car.where(year: @year).eager_load(model: :brand).order("brands.name" => :asc, "models.name" => :asc)

    all_cars = @cars

    # paginacion
    @page = params[:page].to_i
    @page = 1 if @page <= 0
    @pages = (@cars.count / 10.0).ceil
    @cars = @cars.limit(10).offset((@page - 1) * 10).to_a


    # vamos a destacar los 6 autos mas caros
    @highlights = all_cars.to_a
    # ahora ordenamos por precio (negativo, para que queden primero los mayores)
    @highlights = @highlights.sort_by{|car| -car.price}
    # dejamos los 6 primeros
    @highlights = @highlights.first(6)

  end

  def show
    @car = Car.find(params[:id])
  end


end