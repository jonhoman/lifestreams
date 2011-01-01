class AddNewItemsToFeeds < ActiveRecord::Migration
  def self.up
    add_column :feeds, :new_items, :boolean
  end

  def self.down
    remove_column :feeds, :new_items
  end
end
