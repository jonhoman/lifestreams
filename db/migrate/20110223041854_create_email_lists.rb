class CreateEmailLists < ActiveRecord::Migration
  def self.up
    create_table :email_lists do |t|
      t.integer :user_id
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :email_lists
  end
end
