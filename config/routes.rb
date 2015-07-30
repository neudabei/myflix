Myflix::Application.routes.draw do
  root to: "videos#index"
  resources :videos, only: [:show] do
    collection do
      get :search, to: "videos#search"
    end
  end

  get 'ui(/:action)', controller: 'ui'

  get '/genre/:id', to: 'categories#show'

end
