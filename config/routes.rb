Rails.application.routes.draw do

  root to: 'homes#top'

  devise_for :admins
  devise_for :customers

  # ========= 管理者(admin)のルーティング ================
  namespace :admin do
    resource :homes do
      get 'top', on: :collection
    end
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :products, only: [:index, :show, :new, :create, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
    resources :sessions, only: [:new, :create, :destroy]
  end

  # ========= ユーアー(public)のルーティング ================

  resources :products, only: [:index, :show]
  resources :adresess, only: [:index, :create, :edit, :update, :destroy]

  resources :orders, only: [:index, :show, :create, :new] do
    post 'confirm' => 'orders#confirm', as: 'confirm'
    get 'complete' => 'orders#complete', as: 'complete'
  end

  resources :cart_products, only: [:index, :create, :update, :destroy, :destroy_all] do
    delete 'destroy_all' => 'cart_products#destroy_all', as: 'destroy_all'
  end

  resources :customers, only: [:show, :edit, :update, :quit_confirm, :quit] do
    get 'quit_confirm' => 'customers#quit_confirm', as: 'quit_confirm'
    patch 'quit' => 'customers#quit', as: 'quit'
  end

  resources :registrations, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]

  resource :homes do
    collection do
     get :about
    end
  end

end

