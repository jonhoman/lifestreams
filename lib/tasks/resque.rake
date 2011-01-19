require "resque/tasks"

task "resque:setup" => :environment do
  ENV['QUEUE'] = 'feed_creation,feed_updating,twitter_updating'
end

desc "Alias for resque:work (To run workers on Heroku)"
task "jobs:work" => "resque:work"
