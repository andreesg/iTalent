class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :user_id
      t.integer :publication_id

      t.timestamps
    end
    add_index :likes, :user_id
    add_index :likes, :publication_id
    add_index :likes, [:user_id, :publication_id]
  end
end
