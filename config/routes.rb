Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    put 'changePassword' => "users#changePassword"
    resources :users do
      resources :teams, only: [:create, :destroy]
    end
    resources :tokens, only: [:create]
    resources :teams do
      resources :users, only: [:index, :create, :update, :destroy]
      resources :surveys, only: [:create, :destroy]
    end
  end
end
