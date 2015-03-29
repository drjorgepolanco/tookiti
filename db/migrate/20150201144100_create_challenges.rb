class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.references :post, index: true
      t.references :contest, index: true

      t.timestamps null: false
    end
    add_foreign_key :challenges, :posts
    add_foreign_key :challenges, :contests
    add_index :challenges, [:post_id, :contest_id], unique: true
  end
end
