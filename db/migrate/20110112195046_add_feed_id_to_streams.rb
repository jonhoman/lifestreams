class AddFeedIdToStreams < ActiveRecord::Migration
  def self.up
    add_column :streams, :feed_id, :integer
  end

  def self.down
    remove_column :streams, :feed_id
  end
end
