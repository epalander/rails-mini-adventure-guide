Rails.application.routes.draw do
  devise_for :users

  root to: 'adventures#index'

  resources :adventures do
    resources :reviews, only: [:new, :create]
  end
    resources :reviews, only: [:edit, :update, :destroy]

  get "/search" => "adventures#search"

  resources :my_adventures, only: [:new, :create, :destroy, :index]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
