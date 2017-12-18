class CreateStops < ActiveRecord::Migration[5.1]
  def change
    create_table :stops do |t|
      t.string :name
      t.string :address
      t.integer :lng
      t.integer :lat
      t.integer :trip_id
      t.integer :rating

      t.timestamps
    end
  end
end
