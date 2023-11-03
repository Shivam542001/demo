Rails.application.routes.draw do


  root "products#index"
  # root 'products#index'

  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  resources :products

  get 'products/category/:category', to: "products#category", as: "product_category"

  # get '/users/home', to: 'users#home'

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


end
