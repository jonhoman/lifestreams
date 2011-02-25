class AddRecipientsToEmailList < ActiveRecord::Migration
  def self.up
    add_column :email_lists, :recipients, :text
  end

  def self.down
    remove_column :email_lists, :recipients
  end
end
