class CreateAccessLogs < ActiveRecord::Migration
  def change
    create_table :access_logs do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
