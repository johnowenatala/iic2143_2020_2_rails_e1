# frozen_string_literal: true

module FileLoaders
  class JsonFileLoader < FileLoader

    ##
    # Carga toda la información desde "file"
    # Suponemos que la primera file tiene los nombres de las columnas, y luego viene la info
    def load(file)
      json_data = JSON.parse(file.read)
      json_data.each do |attributes|
        record_storage.save(attributes.values)
      end

    end

  end
end