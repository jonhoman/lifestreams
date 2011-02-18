class AddActiveToTwitterAccounts < ActiveRecord::Migration
  def self.up
    add_column :twitter_accounts, :active, :boolean, :default => true
    TwitterAccount.all.each { |account| account.update_attributes!(:active => true) }
  end

  def self.down
    remove_column :twitter_accounts, :active
  end
end
