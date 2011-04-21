class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.integer :from_id
      t.integer :to_id

      t.string :message

      t.timestamps
    end
  end

  def self.down
    drop_table :activities
  end
end
