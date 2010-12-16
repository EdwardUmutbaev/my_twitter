MyTwitter::Application.routes.draw do
  resources :users
  resources :posts
  resources :sessions, :only => [:new, :create, :destroy]

  match 'signup', :to => "users#new"
  match 'signin', :to => "sessions#new"
  match 'signout', :to => "sessions#destroy"

  root :to => "home#index"
end
