require 'net/ftp'

class FtpClient
  class << self
    def init
      @client = Net::FTP.new ENV['FTP_HOST'], ENV['FTP_USER'], ENV['FTP_PASS']
    end

    def put(data)
      self.init

      begin
        @client.chdir "backups/lifestreams"
        @client.puttextfile(data)
      ensure
        @client.close
      end
    end
  end
end
