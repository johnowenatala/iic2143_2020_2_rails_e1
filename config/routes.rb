# config/routes.rb
Rails.application.routes.draw do

  root 'cars#index'

  # listados
  get "marca/:brand_name" => "brands#index", as: 'clients_index_by_brand'
  get "anio/:year" => "years#index", as: 'clients_index_by_year'

  # vistas de un auto
  get "promo/:id" => "clients#show", as: 'show_from_home'
  get "marca/:brand_name/auto/:id" => "brands#show", as: 'show_from_brand'
  get "anio/:year/auto/:id" => "years#show", as: 'show_from_year'


  namespace :admin do
    get 'cars/index'
    post 'cars/load'
  end
end
