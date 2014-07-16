class AddTotalAmountToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :total_amount, :integer
  end
end
