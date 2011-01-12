class AddUserIdToStream < ActiveRecord::Migration
  def self.up
    add_column :streams, :user_id, :integer
  end

  def self.down
    remove_column :streams, :user_id 
  end
end
