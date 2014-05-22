class CreateUserStatistics < ActiveRecord::Migration
  def change
    create_table :user_statistics do |t|
    	t.belongs_to :user
      t.integer :number_events_created, :default => 0
      t.integer :number_events_attended, :default => 0
      t.integer :number_publications_created, :default => 0

      t.timestamps
    end
  end
end
