require ::File.expand_path('../config/environment',  __FILE__)

require 'resque/server'
run Rack::URLMap.new \
  "/"       => Lifestreams::Application
  "/resque" => Resque::Server.new
