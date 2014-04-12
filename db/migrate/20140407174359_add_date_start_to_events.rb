class AddDateStartToEvents < ActiveRecord::Migration
  def change
    add_column :events, :date_start, :datetime
  end
end
