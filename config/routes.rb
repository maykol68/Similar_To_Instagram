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
  resources :users, only: :show, path: '/users', param: :username
  resources :posts 
  root 'posts#index'
  delete 'posts/:id', to: 'posts#destroy'

  
end