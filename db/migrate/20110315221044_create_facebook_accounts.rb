class CreateFacebookAccounts < ActiveRecord::Migration
  def self.up
    create_table :facebook_accounts do |t|
      t.string :username
      t.string :access_token
      t.string :access_token_secret
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :facebook_accounts
  end
end
