class DropDestinations < ActiveRecord::Migration
  def self.up
    drop_table :destinations
  end

  def self.down
    create_table :destinations do |t|
      t.integer :stream_id
      t.integer :twitter_account_id

      t.timestamps
    end
  end
end
