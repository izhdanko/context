Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # root to: 'user#new'
  root to: 'sessions#new'

  get 'login' => 'sessions#new' #, as: :loginius

  # loginius_path => /sessions/new
  # loginius_url => http://localhost:3000/sessions/new

  get 'logout' => 'session#destroy'
  get 'signup' => 'users#new'

  resources :sessions, only: [ :new, :create, :destroy ]
  resources :users
  resources :tasks, only: [ :index, :new, :create ] do
    member do
      post :incontext
      post :step
    end
  end

end
