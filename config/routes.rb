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

    resources :reservations, only: [:new, :create]
  end

  root 'home#index'
  get '/search', to: 'search#index', as: 'search'
end
