require 'spec_helper'

describe CartItemsController do
  let(:cart) { create(:cart) }
  let(:product) { create(:product) }
  before { controller.stub(:current_cart).and_return(cart) }

  describe 'POST create' do
    context '該当商品は追加されてない場合' do
      it '商品のアイテムが作成される' do
        expect {
          post :create, product_id: product.id
        }.to change(CartItem, :count).by(1)
      end
    end

    context '該当商品は既に追加されている場合' do
      it '該当商品項目の数がインクリメントされる' do
        cart.cart_items << CartItem.create(product: product)
        post :create, product_id: product.id

        cart.cart_items.first.quantity.should eq 2
      end
    end
  end
end
