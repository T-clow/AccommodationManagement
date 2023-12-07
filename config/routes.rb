Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resource :account

  resources :rooms do
    collection do
      get 'search'
      get 'search_by_address' # 住所検索のためのアクションを追加
    end

  end

  resources :reservations do
    member do
      post 'confirm'
      patch 'update_confirm'
    end
  end
  
  patch 'reservations/:id', to: 'reservations#update', as: 'update_reservation'

  get '/search', to: 'search#index', as: 'search'
  

  root 'home#index'
end