class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :user, index: true
      t.string :title
      t.string :image

      t.timestamps null: false
    end
    add_index :posts, [:user_id, :created_at]
  end
end
