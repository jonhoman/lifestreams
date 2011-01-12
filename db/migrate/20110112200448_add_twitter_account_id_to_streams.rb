class AddTwitterAccountIdToStreams < ActiveRecord::Migration
  def self.up
    add_column :streams, :twitter_account_id, :integer
  end

  def self.down
    remove_column :streams, :twitter_account_id
  end
end
