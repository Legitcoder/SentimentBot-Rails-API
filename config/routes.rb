Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    put 'changePassword' => "users#changePassword"
    post 'join' => "users#join"
    resources :users do
      resources :teams, only: [:create, :destroy]
      resources :responses, only: [:create, :destroy]
    end
    resources :tokens, only: [:create]
    resources :teams do
      resources :users, only: [:index, :create, :update, :destroy]
      resources :surveys, only: [:create, :destroy] do
        resources :feelings, only: [:create, :destroy]
      end
    end
  end
end
