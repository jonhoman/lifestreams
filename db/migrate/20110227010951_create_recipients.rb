class CreateRecipients < ActiveRecord::Migration
  def self.up
    create_table :recipients do |t|
      t.string :email_address

      t.references :email_list
    end
  end

  def self.down
    drop_table :recipients
  end
end
