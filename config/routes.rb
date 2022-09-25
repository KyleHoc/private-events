Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :events do
    resources :registrations, only: [:new, :create, :destroy]
    member do
      get 'registration'
      get 'unregister'
    end
  end
  root "events#index"
end
