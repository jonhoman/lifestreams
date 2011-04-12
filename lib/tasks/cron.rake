require 'heroku'

desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
  begin
    client = Heroku::Client.new(ENV['HEROKU_USERNAME'], ENV['HEROKU_PASSWORD'])
    client.set_workers(ENV['HEROKU_APP_NAME'], 1)

    # Get all streams
    streams = Stream.all_active

    # Check for feed updates for each stream
    streams.each do |stream|
      puts "Queuing up an update for #{stream.name}"

      stream.feeds.each do |feed|
        Resque.enqueue(FeedUpdaterWorker, stream.id, feed.id)
      end
    end

    sleep 10 # wait for worker to start up

    while Resque.info[:pending] > 0# returns number of pending jobs 
      sleep 5
    end
  ensure
    client.set_workers(ENV['HEROKU_APP_NAME'], 0)
  end
end
