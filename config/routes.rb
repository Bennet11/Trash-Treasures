Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: "callbacks"}
  get 'home/index'

  get 'home/about'

  root 'home#index'
end
