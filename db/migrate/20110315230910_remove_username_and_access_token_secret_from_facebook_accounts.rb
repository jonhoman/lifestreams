class RemoveUsernameAndAccessTokenSecretFromFacebookAccounts < ActiveRecord::Migration
  def self.up
    remove_column :facebook_accounts, :username
    remove_column :facebook_accounts, :access_token_secret
  end

  def self.down
    add_column :facebook_accounts, :username, :string
    add_column :facebook_accounts, :access_token_secret, :string
  end
end
