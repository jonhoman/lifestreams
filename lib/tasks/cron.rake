desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
  if RAILS_ENV == 'production' 
    # Get all streams
    streams = Stream.all_active

    # Check for feed updates for each stream
    streams.each do |stream|
      puts "Queuing up an update for #{stream.name}"

      stream.feeds.each do |feed|
        Resque.enqueue(FeedUpdaterWorker, stream.id, feed.id)
      end
    end
  end
end
