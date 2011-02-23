Lifestreams::Application.routes.draw do
  devise_for :users
 
  match 'dashboard' => 'home#dashboard', :as => 'user_root'
  
  resources :feeds
  resources :twitter_accounts
  resources :streams
  resources :email_lists

  match "/twitter/connect" => "twitter#connect"
  match "/twitter/callback" => "twitter#callback"
  
  root :to => "home#index" 
end
