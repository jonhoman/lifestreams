Lifestreams::Application.routes.draw do
  devise_for :users
 
  get 'dashboard' => 'home#dashboard', :as => 'user_root'
  
  resources :feeds
  resources :twitter_accounts
  resources :streams
  resources :email_lists
  resources :facebook_accounts

  get "/twitter/connect" => "twitter#connect"
  get "/twitter/callback" => "twitter#callback"

  get "/facebook/connect" => "facebook#connect"
  match "/facebook/callback" => "facebook#callback"

  get "/unsubscribe/:hash" => "email_lists#unsubscribe", :as => "unsubscribe"
  get "/import" => "email_lists#import_recipients", :as => "import_email_recipients"
  post "/load_recipients" => "email_lists#load_recipients"
  
  root :to => "home#index" 
end
