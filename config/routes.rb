# config/routes.rb
Rails.application.routes.draw do

  get 'cars/index'
  get 'cars/new'
  post 'cars/create'

end
