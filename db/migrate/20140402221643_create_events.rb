class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :description
      t.string :location
      t.datetime :date_limit
      t.integer :num_attendings
      t.integer :num_invitations
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
