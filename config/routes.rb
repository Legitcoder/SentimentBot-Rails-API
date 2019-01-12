Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :users do
      resources :teams, only: [:create, :destroy]
    end
    resources :tokens, only: [:create]
    resources :teams do
      resources :users, only: [:create, :destroy]
      resources :surveys, only [:create, destroy]
    end
  end
end
