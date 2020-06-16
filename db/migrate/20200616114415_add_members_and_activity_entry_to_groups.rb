class AddMembersAndActivityEntryToGroups < ActiveRecord::Migration[6.0]
  def change
    add_column :groups, :member_id, :integer
    add_column :groups, :activity_entry_id, :integer
  end
end
