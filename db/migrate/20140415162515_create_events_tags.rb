class CreateEventsTags < ActiveRecord::Migration
  def change
    create_table :events_tags,:id => false do |t|
    	t.belongs_to :event
        t.belongs_to :tag
    end
    add_index :events_tags, :tag_id
    add_index :events_tags, :event_id
  end
end
