class AddFeeToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :fee, :integer
  end
end
