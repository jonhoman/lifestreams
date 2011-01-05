Lifestreams::Application.routes.draw do
  devise_for :users

  root :to => "home#index" 
  
  resources :feeds

  resources :streams

  match "/enqueue" => "feeds#enqueue"
end
