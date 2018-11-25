Rails.application.routes.draw do
  devise_for :users
  root 'prototypes#index'

  resources :prototypes do
    resources :comments, only: [:create, :update, :destroy, :edit, :index]
  end
  resources :users, only: [:show, :edit, :update]
  resources :tags, only: [:show, :index]
end
