class AddDistanceToStops < ActiveRecord::Migration[5.1]
  def change
    add_column :stops, :distance, :integer
  end
end
