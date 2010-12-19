Lifestreams::Application.routes.draw do
  match 'streams/new' => 'streams#new'
  match 'streams' => 'streams#create'
end
