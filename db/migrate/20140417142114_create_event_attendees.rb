class CreateEventAttendees < ActiveRecord::Migration
  def change
    create_table :event_attendees do |t|
    	t.integer :attendee_id
    	t.integer :event_id
    	t.integer :status, limit: 1
      t.timestamps
    end
    add_index :event_attendees, :attendee_id
    add_index :event_attendees, :event_id
    add_index :event_attendees, [:attendee_id, :event_id]
  end
end
