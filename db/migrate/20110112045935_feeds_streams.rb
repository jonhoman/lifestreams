class FeedsStreams < ActiveRecord::Migration
  def self.up
    create_table :feeds_streams, :id => false do |t|
      t.references :feed
      t.references :os
      t.timestamps
    end
  end

  def self.down
    drop_table :feeds_streams
  end
end
