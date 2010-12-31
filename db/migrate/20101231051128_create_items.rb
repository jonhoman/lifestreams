class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.references :feed
      t.string :title
      t.text :body
      t.boolean :shared, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
