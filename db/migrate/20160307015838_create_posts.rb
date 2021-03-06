class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :content, null: false, limit: 160
      t.integer :parent_id
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
