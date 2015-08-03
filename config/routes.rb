Myflix::Application.routes.draw do
  root to: "users#front"
  resources :videos, only: [:show, :index] do
    collection do
      get :search, to: "videos#search"
    end
  end

  get 'ui(/:action)', controller: 'ui'

  get '/genre/:id', to: 'categories#show'

  # registration/authentication
  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :users, only: [:show, :create, :edit, :update]

end
