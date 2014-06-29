class RenameTotalAmountToTotal < ActiveRecord::Migration
  def change
    rename_column :orders, :total_amount, :total
  end
end
