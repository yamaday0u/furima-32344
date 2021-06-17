Rails.application.routes.draw do
  get 'users/show'
  root to: "items#index"
  get 'items/search'
  resources :items do
    resources :purchases, only: [:index, :create]
    resources :comments, only: :create
  end
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  resources :users, only: [:index, :show]
end
