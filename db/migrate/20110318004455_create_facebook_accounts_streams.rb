class CreateFacebookAccountsStreams < ActiveRecord::Migration
  def self.up
    create_table :facebook_accounts_streams, :id => false do |t|
      t.integer :facebook_account_id
      t.integer :stream_id
    end
  end

  def self.down
    drop_table :facebook_accounts_streams
  end
end
