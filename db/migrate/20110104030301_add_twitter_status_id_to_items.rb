class AddTwitterStatusIdToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :status_id, :string
  end

  def self.down
    remove_column :items, :status_id
  end
end
