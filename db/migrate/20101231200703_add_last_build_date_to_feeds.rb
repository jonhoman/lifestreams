class AddLastBuildDateToFeeds < ActiveRecord::Migration
  def self.up
    add_column :feeds, :last_build_date, :datetime
  end

  def self.down
    remove_column :feeds, :last_build_date
  end
end
