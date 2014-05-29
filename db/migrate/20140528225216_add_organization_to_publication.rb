class AddOrganizationToPublication < ActiveRecord::Migration
  def change
  	add_column :publications, :organization_id, :integer
  end
end
