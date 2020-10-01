
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
    # De estos 100 autos, vamos a sacar 18 al azar
    @cars = @cars.sample(18)

    # voy a buscar los autos por tienda, para que queden unos pocos de cada tienda, hasta completar 50 autos
    stores = Store.all
    # hash de tienda => array de autos
    cars_by_store = {}
    stores.each do |store|
      # voy a ignorar los 18 autos ya seleccionados
      # los voy a sacar ordenados por año, con los mas antiguos al final
      # porque luego voy a ir sacando del final de cadda lista
      cars_by_store[store] = store.cars.where.not(id: @cars.map(&:id)).order(year: :desc).to_a
    end

    # vamos a destacar los 6 autos mas caros de los mas antiguos por tienda
    highlights = []

    current_store_index = 0
    50.times do |index|
      #elijo una tienda
      store = stores[current_store_index]
      current_store_index += 1
      if current_store_index == stores.length
        current_store_index = 0
      end
      # saco el ultimo de la lista de la tienda y lo agrego
      next_car = cars_by_store[store].pop
      if !next_car.nil?
        highlights << next_car
      end
    end

    # ahora ordenamos por precio (negativo, para que queden primero los mayores)
    highlights = highlights.sort_by{|car| -car.price}
    # dejamos los 20 primeros
    highlights = highlights.first(20)

    # y sacamos 6 al azar
    @highlights = highlights.sample(6)

    # y los agregamos a los autos actuales
    @cars += @highlights
    # por ultimo, revolvemos
    @cars.shuffle!

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


    # vamos a destacar los 6 autos mas caros del año
    @highlights = all_cars.to_a
    # ahora ordenamos por precio (negativo, para que queden primero los mayores)
    @highlights = @highlights.sort_by{|car| -car.price}
    # dejamos los 6 primeros
    @highlights = @highlights.first(6)

  end

  def show
    @brands = Brand.all
    @years = Car.all.order(year: :desc).distinct(:year).limit(7).pluck(:year)

    @car = Car.find(params[:id])
    @highlights = Car.where("year < ?", Date.today.year - 5)
    # voy a sacar 20 de los de precio más alto
    # voy a tomar como filtro el precio del 20% top
    cars = Car.all.order(price: :desc)
    total = cars.count
    # el 20% top debe ser...
    top_price = cars[(total * 0.2).to_i].price
    @highlights = @highlights.select{|car| car.price > top_price}
    # y ahora me quedo con 6 al azar
    @highlights = @highlights.sample(6)
  end

  def show_from_brand
    @brands = Brand.all
    @years = Car.all.order(year: :desc).distinct(:year).limit(7).pluck(:year)

    @brand = Brand.where(name: params[:brand_name]).first

    @car = Car.find(params[:id])
    @highlights = Car
      .where("year < ?", Date.today.year - 5)
      .order(price: :desc)
      .limit(30) # los top 30 precios
      .sample(6) # de ahi saco 6 al azar
  end

  def show_from_year
    @brands = Brand.all
    @years = Car.all.order(year: :desc).distinct(:year).limit(7).pluck(:year)

    @year = params[:year]

    @car = Car.find(params[:id])
    @highlights = Car
      .where("year < ?", Date.today.year - 5)
      .order(price: :desc)
      .limit(30) # los top 30 precios
      .sample(6) # de ahi saco 6 al azar
  end


end