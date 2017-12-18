class CreateActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :activities do |t|
      t.integer :spot_id
      t.string :name
      t.string :photo

      t.timestamps
    end
  end
end
