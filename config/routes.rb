Rails.application.routes.draw do
  # devise_for :users
  mount_devise_token_auth_for 'User', at: 'auth'

  root 'welcome#index'
  resources :posts

end
