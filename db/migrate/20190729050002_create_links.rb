class CreateLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :links do |t|
      t.string :uuid, :null => false
      t.string :title, :null => false
      t.string :passcode, :null => true
      t.string :url, :null => false
      t.integer :isEnabled, :limit => 1, :default => 1
      t.integer :isHighlight, :limit => 1, :default => 0
      t.integer :order, :default => 0
      t.references :user, foreign_key: true, :null => false
      t.timestamp :expired_at, :null => true
      
      t.timestamps
    end
    add_index :links, :uuid
    add_index :links, :title
    add_index :links, :url
  end
end
