class CreateJoinTableForUsersToGroups < ActiveRecord::Migration[6.0]
  def change
    create_join_table :users, :groups, table_name: :membership do |t|
      t.index :user_id
      t.index :group_id
    end
  end
end
