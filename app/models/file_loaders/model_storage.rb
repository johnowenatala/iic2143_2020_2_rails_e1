module FileLoaders
  class ModelStorage < RecordStorage

    ##
    # Guardar un objeto (lo busca y actualiza, o lo crea, según sea el caso)
    # @param [Array] row - arreglo con la informacion a guardar
    def save(row)
      # se que siempre en una fila viene, primero el nombre de la marca
      brand_name = row[0]
      # luego viene el nombre del modelo
      name = row[1]
      # por ultimo el segmento
      segment = row[2]

      # el modelo depende de la marca. Primero debemos encontrar la marca
      brand = Brand.where(name: brand_name).first! # si no lo encontramos, fallamos

      puts "Guardando modelo #{name} de marca #{brand_name} (id: #{brand.id})"

      model = brand.models.where(name: name).first_or_create
      # lo actualizamos
      model.update!(segment: segment)
    end
  end
end