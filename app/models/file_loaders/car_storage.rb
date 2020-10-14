module FileLoaders
  class CarStorage < RecordStorage

    ##
    # Guardar un objeto (lo busca y actualiza, o lo crea, según sea el caso)
    # @param [Array] row - arreglo con la informacion a guardar
    def save(row)
      # se que siempre en una fila viene, primero el nombre de la marca
      brand_name = row[0]
      # luego viene el nombre del modelo
      model_name = row[1]
      # luego viene el año
      year = row[2]
      # precio
      price = row[3]
      # por ultimo transmision y la descripcion
      transmission = row[4]
      description = row[5]

      # buscamos marca y modelo
      # el modelo depende de la marca. Primero debemos encontrar la marca
      brand = Brand.where(name: brand_name).first! # si no lo encontramos, fallamos
      model = brand.models.where(name: model_name).first! # si no lo encontramos, fallamos

      puts "Guardando auto #{year} de marca #{brand_name} (id: #{brand.id}), modelo #{model_name} (id: #{model.id}). Precio: #{price}"

      # buscamos el auto. Notese que aqui notamos que a nuestro modelo le falta algo que sea identificador del auto
      # supondremos que el año y el precio son identificadores (es decir, no pueden actualizar el precio por planilla)
      car = model.cars.where(year: year, price: price).first_or_create

      # por ultimo actualizamos con los otros datos
      car.update!(transmission: transmission, description: description)
    end
  end
end