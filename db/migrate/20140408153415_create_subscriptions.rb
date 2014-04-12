class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.integer :user_id
      t.integer :tag_id
      t.integer :status

      t.timestamps
    end
  end
end
