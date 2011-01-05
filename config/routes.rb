Lifestreams::Application.routes.draw do
  get "home/index"

  devise_for :users

  root :to => "home#index" 
  
  resources :feeds

  resources :streams

  match "/enqueue" => "feeds#enqueue"
end
