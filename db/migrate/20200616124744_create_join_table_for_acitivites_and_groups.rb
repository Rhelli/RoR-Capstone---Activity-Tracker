class CreateJoinTableForAcitivitesAndGroups < ActiveRecord::Migration[6.0]
  def change
    create_join_table :groups, :activities, table_name: :activity_entry do |t|
      t.index :group_id
      t.index :activity_id
    end
  end
end
