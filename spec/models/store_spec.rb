require 'rails_helper'

RSpec.describe Store, type: :model do
  it 'can sell multiple cars' do
    # creamos autos
    cars = create_list(:car, 3)
    # creamos una tienda
    store = create(:store)
    # a la tienda le asignamos los autos
    store.cars = cars
    # y veamos si está en BD
    expect(Store.last.cars).to include(*cars)
    # (aclaracion sintaxis ruby) esto es lo mismo que:
    # expect(Store.last.cars).to include(cars[0], cars[1], cars[2])
  end
end
