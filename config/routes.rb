Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root 'welcome#index'

  resources :posts do
    resources :ratings
    resources :comments
  end

  resources :codereviews

  get 'users/auth/github/callback', to: 'sessions#create'

end
