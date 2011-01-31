class AddBitlyHashToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :bitly_hash, :string
  end

  def self.down
    remove_column :items, :bitly_hash
  end
end
