class StreamsTwitterAccounts < ActiveRecord::Migration
  def self.up
    create_table :streams_twitter_accounts, :id => false do |t|
      t.references :stream
      t.references :twitter_account
      t.timestamps
    end
  end

  def self.down
    drop_table :streams_twitter_accounts
  end
end
