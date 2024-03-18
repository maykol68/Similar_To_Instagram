Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'    
  end

  get '/notifications', to: 'notifications#index', as: 'notifications'

  resources :rooms do
    resources :messages
  end
  resources :likes, only: [:index, :create, :destroy], param: :post_id
  resources :hashtags, only: [:show]
  resources :users, only: [:index, :show], param: :username do
    member do
      post 'follow', to: 'users#follow'
      delete 'unfollow', to: 'users#unfollow'
    end
  end
  get 'users/profile/:username', to: 'users#show_profile', as: 'user_profile'

  resources :messages, only: [:index, :new, :create]
  

  resources :posts do
    resources :comments, only: [:create]
  end
  root 'posts#index'  
end