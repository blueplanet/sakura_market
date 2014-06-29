class ChangeDeliveryTimeTypeToString < ActiveRecord::Migration
  def up
    change_column :orders, :delivery_time, :string
  end

  def down
    add_column :orders, :delivery_time_temp, :integer

    Order.reset_column_information
    Order.update_all delivery_time_temp: 0

    remove_column :orders, :delivery_time
    rename_column :orders, :delivery_time_temp, :delivery_time
  end
end
