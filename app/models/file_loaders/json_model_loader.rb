# frozen_string_literal: true

module FileLoaders
  class JsonModelLoader < ModelLoader

    ##
    # Carga toda la información desde "file"
    # Suponemos que la primera file tiene los nombres de las columnas, y luego viene la info
    def load(file)
      json_data = JSON.parse(file.read)
      puts "===== archivo cargado =====", *json_data, "--------- fin de info cargada ----------"
      # TODO
    end

  end
end