module FileLoaders
  class BrandStorage < RecordStorage


    ##
    # Guardar un objeto (lo busca y actualiza, o lo crea, según sea el caso)
    # @param [Array] row - arreglo con la informacion a guardar
    def save(row)
      # se que siempre viene primero un id que ignoro
      # y luego viene el nombre
      name = row[1]
      puts "Guardando marca #{name}"
      # una marca es algo muy simple: solo un nombre, asi que lo buscamos y si no existe, lo creamos
      Brand.where(name: name).first_or_create
    end
  end
end