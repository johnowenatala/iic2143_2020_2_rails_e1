module FileLoaders
  class BrandLoader < FileLoader

    ##
    # Guardar un objeto (lo busca y actualiza, o lo crea, según sea el caso)
    # @param [String] name - nombre de la marca
    def save(name)
      puts "Guardando marca #{name}"
      # una marca es algo muy simple: solo un nombre, asi que lo buscamos y si no existe, lo creamos
      Brand.where(name: name).first_or_create
    end
  end
end