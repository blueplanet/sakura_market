class AddCheckoutedToCarts < ActiveRecord::Migration
  def change
    add_column :carts, :checkouted, :boolean
  end
end
