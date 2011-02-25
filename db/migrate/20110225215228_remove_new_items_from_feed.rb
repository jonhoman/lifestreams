class RemoveNewItemsFromFeed < ActiveRecord::Migration
  def self.up
    remove_column :feeds, :new_items
  end

  def self.down
    add_column :feeds, :new_items, :boolean
  end
end
