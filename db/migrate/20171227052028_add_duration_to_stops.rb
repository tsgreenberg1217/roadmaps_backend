class AddDurationToStops < ActiveRecord::Migration[5.1]
  def change
    add_column :stops, :duration, :string
  end
end
