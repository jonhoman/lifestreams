class AddIndexToFacebookIdOnFacebookAccounts < ActiveRecord::Migration
  def self.up
    add_index :facebook_accounts, :facebook_id, :unique => true
  end

  def self.down
    remove_index :facebook_accounts, :facebook_id
  end
end
