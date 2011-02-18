desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
  # Get all streams
  streams = Stream.all_active

  # Check for feed updates for each stream
  streams.each do |stream|
    puts "Queuing up an update for #{stream.name}"

    # TODO: refactor call (only pass stream id)
    Resque.enqueue(FeedUpdaterWorker, stream.feed_id, stream.id)
  end
end
