class CreatePublicationsTags < ActiveRecord::Migration
  def change
    create_table :publications_tags, :id => false do |t|
		t.references :publication
        t.references :tag
    end
    add_index :publications_tags, :tag_id
    add_index :publications_tags, :publication_id
  end
end
