Rails.application.routes.draw do
  resources :products
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'conversations#index'
  resources :conversations, only: [:index, :show, :create] do
    resources :messages, only: [:create]
  end

  namespace :admin do
    root 'conversations#index'
    resources :conversations, only: [:index, :show, :update] do
      resources :messages, only: [:create]
      member do
        patch :assign
        patch :close
        patch :reopen
      end
    end
  end
end
