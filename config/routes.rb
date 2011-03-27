Lifestreams::Application.routes.draw do
  devise_for :users
 
  match 'dashboard' => 'home#dashboard', :as => 'user_root'
  
  resources :feeds
  resources :twitter_accounts
  resources :streams
  resources :email_lists
  resources :facebook_accounts

  match "/twitter/connect" => "twitter#connect"
  match "/twitter/callback" => "twitter#callback"

  match "/facebook/connect" => "facebook#connect"
  match "/facebook/callback" => "facebook#callback"

  match "/unsubscribe/:id" => "email_lists#unsubscribe", :as => "unsubscribe"
  match "/import" => "email_lists#import_recipients", :as => "import_email_recipients"
  match "/load_recipients" => "email_lists#load_recipients"
  
  root :to => "home#index" 
end
