Rails.application.routes.draw do
  devise_for :users

  root to: 'adventures#index'

  resources :adventures  do
    resources :reviews, only: [:new, :create]
  end
  resources :reviews, only: [:edit, :update, :destroy]
  resources :my_adventures, only: [:destroy, :index, :create, :new, :update, :edit]

  get "/search" => "adventures#search"



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
