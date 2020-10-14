require 'csv'

module FileLoaders
  class CsvFileLoader < FileLoader

    ##
    # Carga toda la información desde "file"
    # Suponemos que la primera file tiene los nombres de las columnas, y luego viene la info
    def load(file)
      skip_first_row = true
      ::CSV.foreach(file.path) do |row|
        if skip_first_row # si no hemos leido los nombres de columnas, nos saltamos una fila
          skip_first_row = false # ya no es necesario
        else
          # ok, leemos y guardamos la fila
          # usando el almacen de registros
          record_storage.save(row)
        end
      end
    end

  end
end