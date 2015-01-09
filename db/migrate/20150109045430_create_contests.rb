class CreateContests < ActiveRecord::Migration
  def change
    create_table :contests do |t|
      t.string :title
      t.string :poster
      t.text :description
      t.references :user, index: true
      t.boolean :poll, default: false

      t.timestamps null: false
    end
    add_foreign_key :contests, :users
  end
end
