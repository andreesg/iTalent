class CreateEventInvitations < ActiveRecord::Migration
	def change
		create_table :event_invitations do |t|
			t.integer :invitee_id
			t.integer :event_id
			t.integer :status, limit: 1
			t.timestamps
		end
		add_index :event_invitations, :invitee_id
		add_index :event_invitations, :event_id
		add_index :event_invitations, [:invitee_id,:event_id], unique:true
	end
end
