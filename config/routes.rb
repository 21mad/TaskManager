Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    resources :public_folders
    root 'folders#index'
    #root 'session#login'
    get 'session/login'
    get 'session/logout'
    post 'session/create'
    resources :users
    resources :folders
    resources :tasks
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
