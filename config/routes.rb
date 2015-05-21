Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  
  root 'welcome#index'

  resources :posts do
    resources :ratings
  end

  resources :codereviews
end
