desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
  # Get all streams
  streams = Stream.all_active

  # Check for feed updates for each stream
  streams.each do |stream|
    puts "Queuing up an update for #{stream.name}"

    Resque.enqueue(FeedUpdaterWorker, stream.id)
  end
end
