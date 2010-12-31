Lifestreams::Application.routes.draw do
  resources :feeds

  resources :streams

  match "/enqueue" => "feeds#enqueue"
end
