class CreateFeedsStreams < ActiveRecord::Migration
  def self.up
    create_table :feeds_streams, :id => false do |t|
      t.integer :feed_id
      t.integer :stream_id
    end
  end

  def self.down
    drop_table :feeds_streams
  end
end
