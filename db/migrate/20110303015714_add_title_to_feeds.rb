class AddTitleToFeeds < ActiveRecord::Migration
  def self.up
    add_column :feeds, :title, :string
  end

  def self.down
    remove_column :feeds, :title
  end
end
