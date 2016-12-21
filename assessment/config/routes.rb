Rails.application.routes.draw do
  resources :orders
  resources :profiles
  resources :products
  resources :sessions, only: [:new]

  # Sessions
  get 'sessions/login'
  post 'sessions/login' => 'sessions#login_attempt'
  delete 'sessions/logout', to: "sessions#logout"
  get 'sessions/home'
  get 'sessions/profile'
  get 'sessions/setting'

  # get 'users/new'
  resources :users, only: [:new, :create]
  root to: "users#new" 

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
