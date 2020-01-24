class CreateAnalytics < ActiveRecord::Migration[5.2]
  def change
    create_table :analytics do |t|
      t.references :link, foreign_key: true, :null => false
      t.references :user, foreign_key: true, :null => false
      t.string :ip
      t.string :device
      t.string :device_type
      t.string :os
      t.string :browser

      t.timestamps
    end
    add_index :analytics, :ip
    add_index :analytics, :device
    add_index :analytics, :device_type
    add_index :analytics, :os
    add_index :analytics, :browser
  end
end
