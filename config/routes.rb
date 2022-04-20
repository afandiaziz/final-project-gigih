Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :categories, only: [:create, :index, :update, :destroy, :show]
  resources :menu_items, only: [:create, :index, :update, :destroy, :show]
  resources :item_categories, only: [:create, :index, :update, :destroy, :show]
  
  resources :customers, only: [:create, :index, :update, :destroy, :show]
  resources :orders, only: [:create, :index, :update, :show]
end
