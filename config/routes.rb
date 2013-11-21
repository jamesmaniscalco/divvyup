Divvyup::Application.routes.draw do

  resources :people
  resources :item_types

  root 'people#index'

end
