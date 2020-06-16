Rails.application.routes.draw do
  get 'users/show'
  root 'users#show'

  devise_for :users

end
