Rails.application.routes.draw do

  devise_for :users, controllers: {omniauth_callbacks: "callbacks"}

  resources :users, only: :show

  resources :posts

  resources :conversations do
    member do
      post :reply
      post :trash
      post :untrash
    end
  end

  get "mailbox/inbox" => "mailbox#inbox", as: :mailbox_inbox

  get "mailbox/sent" => "mailbox#sent", as: :mailbox_sent

  get "mailbox/trash" => "mailbox#trash", as: :mailbox_trash

  get 'home/index'

  get 'home/about'

  root 'home#index'
end
