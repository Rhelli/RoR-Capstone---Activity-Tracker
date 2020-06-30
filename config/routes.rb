Rails.application.routes.draw do
  root 'users#show'

  devise_for :users
  resources :users, only: [:show]
  resources :activities
  resources :groups
  resources :memberships
  resources :activity_entries, only: [:index]
end
