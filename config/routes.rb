Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    put 'changePassword' => "users#changePassword"
    post 'join' => "users#join"
    resources :users do
      resources :teams, only: [:index, :show, :create, :destroy]
      resources :responses, only: [:index,  :create, :destroy]
    end
    resources :tokens, only: [:create]
    resources :surveys do
      resources :feelings, only: [:index, :create, :destroy]
    end
    resources :responses
    resources :feelings
    resources :teams do
      resources :users, only: [:index, :create, :update, :destroy]
      resources :responses
      resources :surveys, only: [:index, :update, :create, :destroy] do
        resources :feelings, only: [:index, :create, :destroy]
      end
    end
  end
end
