Rails.application.routes.draw do
  get 'users/show'
  root to: "items#index"
  resources :items do
    resources :purchases, only: [:index, :create]
  end
  devise_for :users
  resources :users, only: [:show, :edit]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
