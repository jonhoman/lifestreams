# Load the rails application
require File.expand_path('../application', __FILE__)

# Load heroku vars from local file
heroku_env = File.join(::Rails.root.to_s, 'config', 'heroku_env.rb')
load(heroku_env) if File.exists?(heroku_env)

config.action_mailer.delivery_method = :smtp

ActionMailer::Base.smtp_settings = {
  :address  => "mail.jonhoman.com",
  :port  => 25,
  :user_name  => ENV["EMAIL_USERNAME"],
  :password  => ENV["EMAIL_PASSWORD"],
  :authentication  => :login
}
config.action_mailer.raise_delivery_errors = true

# Initialize the rails application
Lifestreams::Application.initialize!
