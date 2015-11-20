Rails.application.routes.draw do
  root "sessions#index"
  resources :users
  resources :sessions
  resources :secrets
  post '/secrets/like' => 'secrets#like'
  post '/secrets/unlike' => 'secrets#unlike'
end