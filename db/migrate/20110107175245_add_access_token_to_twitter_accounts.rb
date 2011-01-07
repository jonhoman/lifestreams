class AddAccessTokenToTwitterAccounts < ActiveRecord::Migration
  def self.up
    add_column :twitter_accounts, :access_token, :string
    add_column :twitter_accounts, :access_token_secret, :string
  end

  def self.down
    remove_column :twitter_accounts, :access_token 
    remove_column :twitter_accounts, :access_token_secret
  end
end
