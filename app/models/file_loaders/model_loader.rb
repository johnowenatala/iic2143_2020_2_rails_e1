module FileLoaders
  class ModelLoader < FileLoader

    ##
    # Guardar un objeto (lo busca y actualiza, o lo crea, según sea el caso)
    # @param [String] brand_name - nombre de la marca
    # @param [String] name - nombre del modelo
    # @param [String] segment - segmento al que pertenece el modelo (sport, sedan, suv, truck)
    def save(brand_name, name, segment)
      # el modelo depende de la marca. Primero debemos encontrar la marca
      brand = Brand.where(name: brand_name).first! # si no lo encontramos, fallamos

      puts "Guardando modelo #{name} de marca #{brand_name} (id: #{brand.id})"

      model = brand.models.where(name: name).first_or_create
      # lo actualizamos
      model.update!(segment: segment)
    end
  end
end