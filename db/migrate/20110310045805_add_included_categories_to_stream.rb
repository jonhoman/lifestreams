class AddIncludedCategoriesToStream < ActiveRecord::Migration
  def self.up
    add_column :streams, :included_categories, :string
  end

  def self.down
    remove_column :streams, :included_categories
  end
end
