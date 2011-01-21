require ::File.expand_path('../config/environment',  __FILE__)

require 'resque/server'

AUTH_USERNAME = ENV['RESQUE_WEB_USERNAME'] 
AUTH_PASSWORD = ENV['RESQUE_WEB_PASSWORD'] 
if AUTH_PASSWORD
  Resque::Server.use Rack::Auth::Basic do |username, password|
    username == AUTH_USERNAME
    password == AUTH_PASSWORD
  end
end

run Rack::URLMap.new \
  "/"       => Lifestreams::Application,
  "/resque" => Resque::Server.new
