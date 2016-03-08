class CreateFollowerNotifications < ActiveRecord::Migration
  def change
    create_table :follower_notifications do |t|
      t.integer :follower_id
      t.references :notification, index: true, foreign_key: true
    end
    add_index :follower_notifications, :follower_id
  end
end
