# Load the rails application
require File.expand_path('../application', __FILE__)

# Load heroku vars from local file
heroku_env = File.join(::Rails.root.to_s, 'config', 'heroku_env.rb')
load(heroku_env) if File.exists?(heroku_env)


# Initialize the rails application
Lifestreams::Application.initialize!
