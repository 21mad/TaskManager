Rails.application.routes.draw do
  root 'session#login'
  get 'session/login'
  get 'session/logout'
  post 'session/create'
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
