class ChangeFacebookIdToString < ActiveRecord::Migration
  def self.up
    change_column :facebook_accounts, :facebook_id, :string
  end

  def self.down
    change_column :facebook_accounts, :facebook_id, :integer
  end
end
