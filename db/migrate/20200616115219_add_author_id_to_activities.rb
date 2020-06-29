class AddAuthorIdToActivities < ActiveRecord::Migration[6.0]
  def change
    add_column :activities, :author_id, :integer
  end
end
