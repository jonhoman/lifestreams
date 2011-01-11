class AddUserIdToFeeds < ActiveRecord::Migration
  def self.up
    add_column :feeds, :user_id, :integer
  end

  def self.down
    add_column :feeds, :user_id 
  end
end
