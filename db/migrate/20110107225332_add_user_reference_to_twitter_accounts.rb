class AddUserReferenceToTwitterAccounts < ActiveRecord::Migration
  def self.up
    add_column :twitter_accounts, :user_id, :integer
  end

  def self.down
    add_column :twitter_accounts, :user_id
  end
end
