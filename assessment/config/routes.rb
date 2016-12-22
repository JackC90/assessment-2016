Rails.application.routes.draw do
  resources :orders, only: [:index, :show, :create, :destroy] do
    resources :checkouts, only: [:new, :create, :show]
  end
  resources :profiles, except: [:index, :new]
  resources :products

  # Sessions
  get 'sessions/login'
  post 'sessions/login' => 'sessions#login_attempt'
  delete 'sessions/logout', to: "sessions#logout"


  # Omniauth
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')

  # get 'users/new'
  resources :users, only: [:new, :create]
  root to: "products#index" 

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
