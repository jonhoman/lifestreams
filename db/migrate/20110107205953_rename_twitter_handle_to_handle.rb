class RenameTwitterHandleToHandle < ActiveRecord::Migration
  def self.up
    rename_column :twitter_accounts, :twitter_handle, :handle
  end

  def self.down
    rename_column :twitter_accounts, :handle, :twitter_handle
  end
end
