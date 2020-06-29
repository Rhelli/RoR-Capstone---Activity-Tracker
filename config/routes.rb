Rails.application.routes.draw do
  get 'memberships/show/:id' => "memberships#show", as: :memberships_show
  get 'groups/new'
  get 'groups/show/:id' => "groups#show", as: :groups_show
  get 'activity_entries/index'
  get 'activities/new'
  get 'activities/show/:id' => "activities#show", as: :activities_show
  get 'users/show/:id' => "users#show", as: :users_show
  root 'users#show'

  devise_for :users
  resources :activities
  resources :groups
  resources :memberships
end
