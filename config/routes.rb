Divvyup::Application.routes.draw do

  resources :people
  resources :item_types
  resources :items
  resources :uses

  root 'people#index'

end
