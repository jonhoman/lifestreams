class AddStreamReferenceToSources < ActiveRecord::Migration
  def self.up
    add_column :sources, :stream_id, :integer
  end

  def self.down
    remove_column :sources, :stream_id
  end
end
