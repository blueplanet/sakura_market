class AddCartIdToCartItem < ActiveRecord::Migration
  def change
    add_reference :cart_items, :cart, index: true
  end
end
