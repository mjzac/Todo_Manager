Rails.application.routes.draw do
  root to: "home#index"
  resources :todos
  resources :users

  post "users/login", to: "users#login"
end
