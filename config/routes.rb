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
      get 'confirm' # 確認画面表示
      patch 'update_confirmation' # 確認画面からの確定処理
    end
  end
  get '/search', to: 'search#index', as: 'search'
  

  root 'home#index'
end
