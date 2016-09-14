Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: "callbacks" }

  resources :posts do
    resources :watchlists, only: [:create, :destroy]
  end

  resources :profiles, only: [:show]

  resources :categories

  resources :charges, only: [:create]

  resources :conversations do
    member do
      post :reply
      post :trash
      post :untrash
    end
  end

  resources :users, only: :show

  get 'search' => 'search#index', as: :search

  get "mailbox/inbox" => "mailbox#inbox", as: :mailbox_inbox

  get "mailbox/sent" => "mailbox#sent", as: :mailbox_sent

  get "mailbox/trash" => "mailbox#trash", as: :mailbox_trash

  get 'categories/show'

  get 'profiles/show'

  get 'home/index'

  get 'home/about'

  root 'home#index'
end
