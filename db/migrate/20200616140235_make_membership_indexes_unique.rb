class MakeMembershipIndexesUnique < ActiveRecord::Migration[6.0]
  def change
    remove_index :memberships, :group_id
    remove_index :memberships, :user_id
    add_index :memberships, [:group_id, :user_id], unique: true
  end
end
