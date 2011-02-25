class CreateEmailListsStreams < ActiveRecord::Migration
  def self.up
    create_table :email_lists_streams, :id => false do |t|
      t.integer :email_list_id
      t.integer :stream_id
    end
  end

  def self.down
    drop_table :email_lists_streams
  end
end
