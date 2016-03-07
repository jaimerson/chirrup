class CreateFollowership < ActiveRecord::Migration
  def change
    create_table :followerships do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :follower_id

      t.timestamps null: false
    end
    add_index :followerships, :follower_id
  end
end
