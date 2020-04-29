Rails.application.routes.draw do
  devise_for :users

  root to: 'pages#home'

  resources :adventures do
    resources :reviews, only: [:new, :create, :edit, :update, :destroy]
  end
    resources :reviews, only: [:destroy]

  get "/search" => "adventures#search"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
