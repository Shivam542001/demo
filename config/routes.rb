Rails.application.routes.draw do

  # get 'orders/index'
  # get 'orders/show'
  # get 'orders/new'
  # post 'orders/new', to: "orders#create"
  # get 'carts/show'


  root 'users#home'
  # root 'products#index'

  devise_for :users

  resources :users
  resources :products

  get 'products/:category', to: "product#index", as: "product_category"

  get '/users/home', to: 'users#home'

  get 'carts/:id', to: "carts#show", as: "cart"
  delete 'carts/:id', to: "carts#destroy"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :orders, :only => [:index, :show, :new, :create]




  get 'cart_products/:id/add', to: "cart_products#add_quantity", as: "cart_product_add"
  get 'cart_products/:id/reduce', to: "cart_products#reduce_quantity", as: "cart_product_reduce"
  post 'cart_products', to: "cart_products#create"
  get 'cart_products/:id', to: "cart_products#show", as: "cart_product"
  delete 'cart_products/:id', to: "cart_products#destroy"



  # Defines the root path route ("/")
  # root "posts#index"
end
