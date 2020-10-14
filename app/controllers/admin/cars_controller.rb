module Admin
  class CarsController < BaseController
    def index
      # TODO
    end

    def load
      type = params[:load_type]
      file = params[:file]
      filename = file.original_filename.downcase


      record_storage = case type
      when "brands"
        FileLoaders::BrandStorage.new
      when "models"
        FileLoaders::ModelStorage.new
      when "cars"
        FileLoaders::CarStorage.new
      else
        raise "No implementado"
      end

      file_loader = if filename.end_with?('.csv')
        FileLoaders::CsvFileLoader.new(record_storage)
      elsif filename.end_with?('.xlsx')
        FileLoaders::ExcelFileLoader.new(record_storage)
      elsif filename.end_with?('.json')
        FileLoaders::JsonFileLoader.new(record_storage)
      else
        raise "Formato de archivo desconocido"
      end

      ActiveRecord::Base.transaction do
        # vamos a hacer la carga dentro de una transacción
        file_loader.load file
      end
      redirect_to admin_cars_index_url, notice: "#{type} loaded"
    end
  end
end
