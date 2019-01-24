Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    put 'changePassword' => "users#changePassword"
    post 'oauth' => "users#oauth"
    post 'join' => "users#join"
    post 'stripe' => "subscriptions#stripe"
    delete 'subscriptions' => "subscriptions#cancel"

    post 'upload' => "users#upload"

    post 'saveDeviceToken' => "users#save_device_token"

    resources :subscriptions

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
