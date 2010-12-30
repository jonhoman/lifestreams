class AddNameToFeeds < ActiveRecord::Migration
  def self.up
    add_column :feeds, :name, :string
  end

  def self.down
    remove_column :feeds, :name
  end
end
