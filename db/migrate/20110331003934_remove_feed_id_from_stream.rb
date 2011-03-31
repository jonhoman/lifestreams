class RemoveFeedIdFromStream < ActiveRecord::Migration
  def self.up
    streams = Stream.all
    streams.each do |stream|
      stream.update_attributes!( :feeds => [Feed.find(stream.feed_id)] ) if stream.feed_id
    end

    remove_column :streams, :feed_id
  end

  def self.down
    add_column :streams, :feed_id, :integer
  end
end
