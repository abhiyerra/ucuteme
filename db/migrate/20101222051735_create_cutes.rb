class CreateCutes < ActiveRecord::Migration
  def self.up
    create_table :cutes do |t|
      t.integer :user_id

      t.string :cuted_fid

      t.text :secret_message

      t.timestamps
    end

    add_index :cutes, :user_id
    add_index :cutes, :cuted_fid
  end

  def self.down
    drop_table :cutes
  end
end
