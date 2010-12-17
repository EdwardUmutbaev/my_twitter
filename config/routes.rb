MyTwitter::Application.routes.draw do
  resources :users do
    member do
      get :following, :followers
    end
  end
  
  resources :sessions, :only => [:new, :create, :destroy]
  resources :posts
  resources :friendships,   :only => [:create, :destroy]

  match 'signup', :to => "users#new"
  match 'signin', :to => "sessions#new"
  match 'signout', :to => "sessions#destroy"

  root :to => "home#index"
end
