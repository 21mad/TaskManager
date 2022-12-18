Rails.application.routes.draw do
  resources :public_folders
  root 'folders#index'
  #root 'session#login'
  get 'session/login'
  get 'session/logout'
  post 'session/create'
  resources :users
  resources :folders
  resources :tasks
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
