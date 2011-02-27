class AddRecipientsToEmailList < ActiveRecord::Migration
  def self.up
    add_column :email_lists, :recipients_text, :text
  end

  def self.down
    remove_column :email_lists, :recipients_text
  end
end
