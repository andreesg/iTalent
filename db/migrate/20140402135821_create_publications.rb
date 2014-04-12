class CreatePublications < ActiveRecord::Migration
  def change
    create_table :publications do |t|
      t.text :text

      t.timestamps
    end
  end
end
