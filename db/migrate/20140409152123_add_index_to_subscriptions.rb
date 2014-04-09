class AddIndexToSubscriptions < ActiveRecord::Migration
  def change
    add_index :subscriptions, :user_id
    add_index :subscriptions, :tag_id
    add_index :subscriptions, [:user_id,:tag_id],unique:true
  end
end
