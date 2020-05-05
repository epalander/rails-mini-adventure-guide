Rails.application.routes.draw do
  devise_for :users

  root to: 'adventures#index'

  resources :adventures do
    resources :reviews, only: [:new, :create]
    resources :my_adventures, only: [:new, :create, :destroy, :index]
  end
  resources :reviews, only: [:edit, :update, :destroy]

  get "/search" => "adventures#search"



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
