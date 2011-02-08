class RemoveTwitterAccountIdFromStream < ActiveRecord::Migration
  def self.up
    remove_column :streams, :twitter_account_id
  end

  def self.down
    add_column :streams, :twitter_account_id, :integer
  end
end
