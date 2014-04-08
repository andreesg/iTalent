class AddUserRefToPublications < ActiveRecord::Migration
  def change
    add_reference :publications, :creator, index: true
  end
end
