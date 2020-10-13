module FileLoaders
  class FileLoader
    ##
    # Carga toda la información desde "file"
    # @param [ActionDispatch::Http::UploadedFile, File] file
    # Método abstracto. Su implementacion depende de las sub-clases
    def load(file)
      raise "Not implemented"
    end

    protected

    ##
    # Guardar un objeto (lo busca y actualiza, o lo crea, según sea el caso)
    # Método abstracto. Su implementación depende de las sub-clases
    def save(*attributes)
      raise "Not implemented"
    end
  end
end