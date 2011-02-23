class CreateStreamsTwitterAccounts < ActiveRecord::Migration
  def self.up
    create_table :streams_twitter_accounts, :id => false do |t|
      t.integer :stream_id
      t.integer :twitter_account_id
    end
  end

  def self.down
    drop_table :streams_twitter_accounts
  end
end
