Rails.application.routes.draw do

  devise_for :users, controllers: {omniauth_callbacks: "callbacks"}

  resources :conversations, only: [:index, :show, :destroy]

  resources :messages, only: [:new, :create]
  
  resources :posts

  get 'home/index'

  get 'home/about'

  root 'home#index'
end
