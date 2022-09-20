Rails.application.routes.draw do
  resources :users
  resources :events
  devise_for :users
  root "events#index"
end
