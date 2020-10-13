module Admin
  class CarsController < BaseController
    def index
      # TODO
    end

    def load
      type = params[:load_type]
      file = params[:file]
      filename = file.original_filename.downcase
      file_loader = case type
      when "brands"
        if filename.end_with?('.csv')
          FileLoaders::CsvBrandLoader.new
        elsif filename.end_with?('.xlsx')
          FileLoaders::ExcelBrandLoader.new
        else
          raise "Formato de archivo desconocido"
        end
      when "models"
        if filename.end_with?('.csv')
          FileLoaders::CsvModelLoader.new
        elsif filename.end_with?('.xlsx')
          FileLoaders::ExcelModelLoader.new
        else
          raise "Formato de archivo desconocido"
        end
      else
        raise "No implementado"
      end
      ActiveRecord::Base.transaction do
        # vamos a hacer la carga dentro de una transacción
        file_loader.load file
      end
      redirect_to admin_cars_index_url, notice: "#{type} loaded"
    end
  end
end
