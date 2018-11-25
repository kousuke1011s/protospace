Rails.application.routes.draw do
  devise_for :users
  root 'prototypes#index'

  resources :prototypes do
    resources :comments, only: [:create, :update, :destroy, :index]
  end

  resources :users, only: [:show, :edit, :update]
  resources :tags, only: [:show, :index]

  post  '/like/:prototype_id' => 'likes#like', as: 'like'
  delete '/like/:prototype_id' => 'likes#unlike', as: 'unlike'
end
