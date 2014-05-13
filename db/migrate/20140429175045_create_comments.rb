class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :text, limit: 500
      t.integer :publication_id
      t.integer :creator_id

      t.timestamps
    end
  end
end
