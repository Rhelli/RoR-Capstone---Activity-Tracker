class ModifyUnqiueIndexes < ActiveRecord::Migration[6.0]
  def change
    remove_index :memberships, [:group_id, :user_id]
    add_index :memberships, :group_id
    add_index :memberships, :user_id
    remove_index :activity_entries, [:activity_id, :group_id]
    add_index :activity_entries, :activity_id, unique: true
    add_index :activity_entries, :group_id
  end
end
