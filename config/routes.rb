Divvyup::Application.routes.draw do

  resources :people
  
  resources :item_types
  
  resources :items do
    post :finish
  end
  
  resources :uses

  
  root 'items#index'

end
