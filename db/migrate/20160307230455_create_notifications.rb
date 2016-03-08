class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :notification_type, null: false, default: 0
      t.boolean :read, null: false, default: false

      t.timestamps null: false
    end
  end
end
