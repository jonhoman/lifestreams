class AddActiveToStream < ActiveRecord::Migration
  def self.up
    add_column :streams, :active, :boolean, :default => true
  end

  def self.down
    remove_column :streams, :active
  end
end
