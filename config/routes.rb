Rails.application.routes.draw do

  devise_for :admins
  devise_for :customers,
    path: '',
    path_names: {
      sign_up: '',
      sign_in: 'login',
      sign_out: 'logout',
      registration: "signup",
    },
    controllers: {
      sessions:      'customers/sessions',
      passwords:     'customers/passwords',
      registrations: 'customers/registrations'
    }

  # ========= ユーザー(public)のルーティング ================
  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'

    resources :products, only: [:index, :show]
    resources :addresses, only: [:index, :create, :edit, :update, :destroy]

    post 'orders/confirm' => 'orders#confirm'
    get 'orders/complete' => 'orders#complete'

    resources :orders, only: [:index, :show, :create, :new]

    resources :cart_products, only: [:index, :create, :update]
    delete 'cart_products/destroy_all' => 'cart_products#destroy_all'
    delete 'cart_products/:id' => 'cart_products#destroy', as: 'destroy_cart_product'

    resource :customers, only: [:edit, :update]
    get 'customers/my_page' => 'customers#show', as: 'customer_show'
    get 'customers/quit_confirm' => 'customers#quit_confirm'
    patch 'customers/quit' => 'customers#quit'
  end

  # ========= 管理者(admin)のルーティング ================
  namespace :admin do
    get '/' => 'homes#top', as: 'top'
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :products, only: [:index, :show, :new, :create, :edit, :update]
    resources :orders, only: [:show, :update] do
    resources :order_details, only: [:update]
    end
  end

end

