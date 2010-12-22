class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :uid
      t.boolean :is_subscribed

      t.timestamps
    end

    add_index :users, :uid
  end

  def self.down
    drop_table :users
  end
end
