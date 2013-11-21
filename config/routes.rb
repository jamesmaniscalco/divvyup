Divvyup::Application.routes.draw do

  resources :people
  resources :item_types
  resources :items

  root 'people#index'

end
