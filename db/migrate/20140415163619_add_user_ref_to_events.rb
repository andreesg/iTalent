class AddUserRefToEvents < ActiveRecord::Migration
  def change
  	add_reference :events, :creator, index: true
  end
end
