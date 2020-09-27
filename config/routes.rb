# config/routes.rb
Rails.application.routes.draw do

  root 'clients#index'

  # listados
  get "marca/:brand_name" => "clients#brand", as: 'clients_index_by_brand'
  get "anio/:year" => "clients#year", as: 'clients_index_by_year'

  # vistas de un auto
  get "promo/:id" => "clients#show", as: 'show_from_home'
  get "marca/:brand_name/auto/:id" => "clients#show_from_brand", as: 'show_from_brand'
  get "anio/:year/auto/:id" => "clients#show_from_year", as: 'show_from_year'

end
