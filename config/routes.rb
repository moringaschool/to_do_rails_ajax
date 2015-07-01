Rails.application.routes.draw do
  root :to => 'lists#index'

  get "/login" => "sessions#new"
  post "/login" => "sessions#create"
  get "/logout" => "sessions#destroy", as: :logout

  resources :lists do
    resources :tasks, :except => [:show, :index]
  end

  resources :users
end
