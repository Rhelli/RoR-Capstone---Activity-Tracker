class AddCreatorToGroups < ActiveRecord::Migration[6.0]
  def change
    add_column :groups, :creator_id, :integer
  end
end
