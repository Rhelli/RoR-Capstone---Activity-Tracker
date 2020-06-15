class CreateActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :activities do |t|
      t.string :name
      t.integer :amount
      t.integer :calories

      t.timestamps
    end
  end
end
