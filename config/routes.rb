Lifestreams::Application.routes.draw do
  devise_for :users

  root :to => "home#index" 
 
  match 'dashboard' => 'home#dashboard', :as => 'user_root'
  
  resources :feeds

  resources :streams

  match "/enqueue" => "feeds#enqueue"

  match "/twitter/connect" => "twitter#connect"
  match "/twitter/callback" => "twitter#callback"
end
