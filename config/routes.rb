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

  resources :reservations, only: [:new, :create, :show, :update] do
    get 'confirm', on: :member, as: :confirm
  end

  get '/search', to: 'search#index', as: 'search'
  

  root 'home#index'
end
