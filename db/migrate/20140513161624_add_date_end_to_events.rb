class AddDateEndToEvents < ActiveRecord::Migration
  def change
    add_column :events, :date_end, :datetime
  end
end
