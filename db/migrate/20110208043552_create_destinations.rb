class CreateDestinations < ActiveRecord::Migration
  def self.up
    create_table :destinations do |t|
      t.integer :stream_id
      t.integer :twitter_account_id

      t.timestamps
    end
  end

  def self.down
    drop_table :destinations
  end
end
