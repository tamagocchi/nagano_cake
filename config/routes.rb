Rails.application.routes.draw do
  devise_for :admins
  devise_for :customers

  resource :customers do
     get 'quit_confirm', on: :collection
  end

  resources :adresess, only: [:index, :create, :edit, :update, :destroy]
  resources :genres, only: [:index, :create, :edit, :update]
  resources :orders, only: [:index, :show, :order_status, :making_status, :order_info, :order_confirm, :order_complete]
  resources :products, only: [:index, :show, :new, :create, :edit, :update]
  resources :cart_products, only: [:index, :create, :update, :destroy]

  resource :homes do
    collection do
     get :about, :shoplist
    end
  end
end
