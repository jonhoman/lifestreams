class RenameBitlyHashToBitlyUrl < ActiveRecord::Migration
  def self.up
    rename_column :items, :bitly_hash, :bitly_url
  end

  def self.down
    rename_column :items, :bitly_url, :bitly_hash
  end
end
