class AddUniqueIndexToLike < ActiveRecord::Migration
  def change
  	remove_index :likes, ["user_id", "publication_id"]
  	add_index :likes, ["user_id", "publication_id"], unique: true
  end
end
