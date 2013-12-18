Divvyup::Application.routes.draw do

  devise_for :groups
  resources :people
  
  resources :item_types
  
  resources :items do
    post :finish
  end
  
  resources :uses

  
  root 'items#index'

end
