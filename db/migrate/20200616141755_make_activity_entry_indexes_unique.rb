class MakeActivityEntryIndexesUnique < ActiveRecord::Migration[6.0]
  def change
    remove_index :activity_entries, :activity_id
    remove_index :activity_entries, :group_id
    add_index :activity_entries, [:activity_id, :group_id], unique: true
  end
end
