class AddPublishedDateAndLinkToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :published_date, :datetime
    add_column :items, :link, :string
  end

  def self.down
    remove_column :items, :published_date
    remove_column :items, :link
  end
end
