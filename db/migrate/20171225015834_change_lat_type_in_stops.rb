class ChangeLatTypeInStops < ActiveRecord::Migration[5.1]
  def change
    change_column :stops, :lat, :float
    change_column :stops, :lng, :float

  end
end
