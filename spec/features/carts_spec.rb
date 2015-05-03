require 'rails_helper'

feature 'ユーザは、自分のカートを管理したい' do
  background do
    FactoryGirl.create_list :product, 3

    login
    visit products_path
  end

  given(:product) { Product.first }

  scenario 'カタログページで商品をカートに追加出来る' do
    first(:link, I18n.t('products.common.add_to_cart')).click

    expect(page.current_path).to eq cart_path(Cart.first)
    expect(page).to have_content I18n.t('cart_items.create.created')
    expect(page).to have_content product.name
  end

  context '商品はカートに追加されている場合' do
    background { first(:link, I18n.t('products.common.add_to_cart')).click }

    scenario 'カートにある不要な商品を削除出来る' do
      within 'table tbody tr:first-child' do
        first(:link, I18n.t('strings.delete')).click
      end

      expect(page).to have_content I18n.t('cart_items.destroy.deleted')
      expect(page).to_not have_content product.name
    end

    scenario 'カートにある商品の数を変更出来る' do
      within 'table tbody tr:first-child' do
        fill_in 'cart_item_quantity', with: 4
        click_button I18n.t('strings.update')
      end

      expect(page).to have_content I18n.t('cart_items.update.updated')
    end
  end
end
