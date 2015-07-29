Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  get '/home', to: 'videos#index'
  get '/video', to: 'videos#show'
  get '/genre/:id', to: 'categories#show'

end
