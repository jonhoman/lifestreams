class CreateTwitterAccounts < ActiveRecord::Migration
  def self.up
    create_table :twitter_accounts do |t|
      t.string :twitter_handle

      t.timestamps
    end
  end

  def self.down
    drop_table :twitter_acconts
  end
end
