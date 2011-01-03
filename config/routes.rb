Lifestreams::Application.routes.draw do
  devise_for :users

  root :to => "streams#index" 
  
  resources :feeds

  resources :streams

  match "/enqueue" => "feeds#enqueue"
end
