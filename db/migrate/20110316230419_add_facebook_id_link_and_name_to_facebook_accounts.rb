class AddFacebookIdLinkAndNameToFacebookAccounts < ActiveRecord::Migration
  def self.up
    add_column :facebook_accounts, :facebook_id, :integer
    add_column :facebook_accounts, :link, :string
    add_column :facebook_accounts, :name, :string
  end

  def self.down
    remove_column :facebook_accounts, :facebook_id
    remove_column :facebook_accounts, :link
    remove_column :facebook_accounts, :name
  end
end
