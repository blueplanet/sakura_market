class CartItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart

  delegate :name, :price, to: :product
end
