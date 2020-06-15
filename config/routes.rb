Rails.application.routes.draw do
  root 'user#profile'
  
  devise_for :users

end
