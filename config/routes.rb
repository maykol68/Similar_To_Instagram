Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'    
  end

  resources :likes, only: [:index, :create, :destroy], param: :post_id
  resources :users, only: :show, path: '/users', param: :username do
    member do
      post 'follow'
      delete 'unfollow'
    end
  end
  resources :posts do
    resources :comments, only: [:create]
  end
  root 'posts#index'
  post 'search', to: 'search#search', as: 'search'

  post 'search/suggestions', to: 'search#suggestions', as: 'search_suggestions'

  
end