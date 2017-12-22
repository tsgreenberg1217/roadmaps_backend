class AddOrderToStop < ActiveRecord::Migration[5.1]
  def change
    add_column :stops, :order, :integer
  end
end
