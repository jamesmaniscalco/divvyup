Divvyup::Application.routes.draw do

  devise_for :groups
  resources :people
  
  resources :item_types
  
  resources :items do
    post :finish
  end
  
  resources :uses

  
  authenticated :group do
    root to: 'items#index', as: "authenticated_root"
  end

  unauthenticated do
    root to: 'welcome#index', as: "unauthenticated_root"
  end

end
