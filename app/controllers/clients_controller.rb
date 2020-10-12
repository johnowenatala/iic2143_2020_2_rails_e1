
class ClientsController < ApplicationController

  before_action :load_menu_elements
  before_action :load_highlighs

  protected

  def paginate(cars)
    # paginacion
    @page = params[:page].to_i
    @page = 1 if @page <= 0
    @pages = (cars.count / 10.0).ceil
    cars.limit(10).offset((@page - 1) * 10).to_a
  end

  def load_menu_elements
    @brands = Brand.all
    @years = Car.all.order(year: :desc).distinct(:year).limit(7).pluck(:year)
  end

  def load_highlighs
    @highlights = Car.highlighted.most_expensive_first.limit(10).shuffle
  end

end