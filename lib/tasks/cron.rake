require 'heroku'

namespace :lifestreams do
  desc "This task is called by the Heroku cron add-on"
  task :update => :environment do
    begin
      puts "[#{Time.now}] lifestreams:update started"
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

      while Resque.info[:pending] > 0 # returns number of pending jobs 
        sleep 5
      end
    ensure
      client.set_workers(ENV['HEROKU_APP_NAME'], 0)
      puts "[#{Time.now}] lifestreams:update complete"
    end
  end
end

task :cron => :environment do
  Rake::Task['lifestreams:update'].invoke
end

namespace :heroku do
  desc "PostgreSQL database backups from Heroku to ftp"
  task :backup => :environment do
    begin
      puts "[#{Time.now}] heroku:backup started"
      name = "#{ENV['APP_NAME']}-#{Time.now.strftime('%Y-%m-%d-%H%M%S')}.dump"
      db = ENV['DATABASE_URL'].match(/postgres:\/\/([^:]+):([^@]+)@([^\/]+)\/(.+)/)
      system "PGPASSWORD=#{db[2]} pg_dump -Fc --username=#{db[1]} --host=#{db[3]} #{db[4]} > tmp/#{name}"

      FtpClient.put "#{ENV['APP_ROOT']}/tmp/#{name}"

      system "rm tmp/#{name}"
      puts "[#{Time.now}] heroku:backup complete"
    # rescue Exception => e
    #   require 'toadhopper'
    #   Toadhopper(ENV['hoptoad_key']).post!(e)
    end
  end
end

task :cron => :environment do
  Rake::Task['heroku:backup'].invoke
end

