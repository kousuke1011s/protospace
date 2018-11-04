Rails.application.routes.draw do
  devise_for :users
  root 'prototypes#index'

  resources :prototypes
  resources :users, only: [:show, :edit, :update]
  resources :likes, only: [:create, :destory]
end