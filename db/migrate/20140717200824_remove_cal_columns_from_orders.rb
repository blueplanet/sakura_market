class RemoveCalColumnsFromOrders < ActiveRecord::Migration
  def change
    remove_columns :orders, :postage, :tax, :fee, :total
  end
end
