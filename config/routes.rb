Rails.application.routes.draw do
  root 'user#show'

  devise_for :users

end
