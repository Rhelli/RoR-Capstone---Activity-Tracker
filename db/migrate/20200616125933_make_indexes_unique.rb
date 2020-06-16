class MakeIndexesUnique < ActiveRecord::Migration[6.0]
  def change
    remove_index :activity_entry, :activity_id
    remove_index :activity_entry, :group_id
    add_index :activity_entry, [:activity_id, :group_id], unique: true
    
    remove_index :membership, :group_id
    remove_index :membership, :user_id
    add_index :membership, [:user_id, :group_id], unique: true
  end
end
