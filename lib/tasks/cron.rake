desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
  # Get all streams
  # Check for feed updates for each stream
  # Post to twitter account if feed updated
end
