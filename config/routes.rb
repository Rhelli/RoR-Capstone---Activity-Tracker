Rails.application.routes.draw do
  get 'memberships/show'
  get 'groups/new'
  get 'groups/show'
  get 'activity_entries/show'
  get 'activities/new'
  get 'activities/show'
  get 'users/show'
  root 'users#show'

  devise_for :users
  resources :activities
  resources :groups
end
