class AddHashValueToRecipients < ActiveRecord::Migration
  def self.up
    add_column :recipients, :hash_value, :string

    Recipient.all.each do |recipient|
      hash = Digest::SHA2.new << recipient.to_s

      recipient.update_attributes! :hash_value => hash.hexdigest
    end
  end

  def self.down
    remove_column :recipients, :hash_value
  end
end
