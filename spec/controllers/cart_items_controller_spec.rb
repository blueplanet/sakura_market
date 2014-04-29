require 'spec_helper'

describe CartItemsController do
  let(:user) { create(:user) }
  let(:product) { create(:product) }
  before { sign_in user }

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
        post :create, product_id: product.id
        post :create, product_id: product.id

        expect(CartItem.count).to eq 1
        expect(CartItem.first.quantity).to eq 2
      end
    end
  end
end
