# frozen_string_literal: true

module FileLoaders
  class ExcelBrandLoader < BrandLoader

    ##
    # Carga toda la información desde "file"
    # Suponemos que la primera file tiene los nombres de las columnas, y luego viene la info
    def load(file)
      skip_first_row = true
      col_names = nil
      xlsx = Roo::Excelx.new(file.path)
      # @type [Array<Excelx::Cell>] row
      xlsx.each_row_streaming do |row|
        if skip_first_row # si no hemos leido los nombres de columnas, nos saltamos una fila
          skip_first_row = false # ya no es necesario
        else
          # ok, leemos y guardamos la fila
          # row[1] es un Excelx::Cell, para obtener su valor usamos el metodo value
          save(row[1].value)
        end
      end

    end

  end
end