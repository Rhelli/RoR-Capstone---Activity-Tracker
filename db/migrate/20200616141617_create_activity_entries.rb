class CreateActivityEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :activity_entries do |t|
      t.references :activity, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
