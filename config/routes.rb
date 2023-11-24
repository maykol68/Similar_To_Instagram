Rails.application.routes.draw do
  resources :posts, path: '/posts'
  resources :favorites, only: [:create, :destroy], param: :post_id


  devise_for :users, controllers: {
    registrations:'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }   
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end