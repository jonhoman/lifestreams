class AddCategoriesToItem < ActiveRecord::Migration
  def self.up
    add_column :items, :categories, :text
  end

  def self.down
    remove_column :items, :categories
  end
end
