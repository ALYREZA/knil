class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email,:null => false
      t.string :username,:null => false
      t.integer :status,:limit => 1,:default => 0
      t.timestamp :expired_at,:default =>  7.day.from_now
      t.string :password_digest

      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :username, unique: true
  end
end
