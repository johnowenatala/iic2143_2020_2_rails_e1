module FileLoaders
  ##
  # Almacén de registros.
  # Se encarga de guardar los registros a partir de una "fila" de datos
  class RecordStorage

    ##
    # Guardar un objeto (lo busca y actualiza, o lo crea, según sea el caso)
    # Método abstracto. Su implementación depende de las sub-clases
    # @param [Array] row - arreglo con la informacion a guardar
    def save(row)
      raise "Not implemented"
    end

  end
end