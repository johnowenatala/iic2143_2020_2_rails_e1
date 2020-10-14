module FileLoaders
  class FileLoader

    ##
    # Almacen de registros. Se encarga de guardar los registros a partir de una "fila" de datos
    # @return [RecordStorage]
    attr_reader :record_storage

    ##
    # Crea un cargador de archivo que puede crear registros usando el
    # almacen de registros entregado
    # @param [RecordStorage] record_storage
    def initialize(record_storage)
      @record_storage = record_storage
    end

    ##
    # Carga toda la información desde "file"
    # @param [ActionDispatch::Http::UploadedFile, File] file
    # Método abstracto. Su implementacion depende de las sub-clases
    def load(file)
      raise "Not implemented"
    end

  end
end