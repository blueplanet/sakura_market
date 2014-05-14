require 'spec_helper'

feature 'ユーザは、自分のカートを管理したい' do
  background do
    FactoryGirl.create_list :product, 3

    login
    visit root_path
  end

  given(:product) { Product.first }

  scenario 'カタログページで商品をカートに追加出来る' do
    first(:link, 'カートに追加').click

    expect(page.current_path).to eq cart_path(Cart.first)
    expect(page).to have_content '商品をカートに追加しました。'
    expect(page).to have_content product.name
  end

  context '商品はカートに追加されている場合' do
    background { first(:link, 'カートに追加').click }

    scenario 'カートにある不要な商品を削除出来る' do
      within 'table tbody tr:first-child' do
        first(:link, '削除').click
      end

      expect(page).to have_content '商品をカートから削除しました'
      expect(page).to_not have_content product.name
    end

    scenario 'カートにある商品の数を変更出来る' do
      within 'table tbody tr:first-child' do
        fill_in 'cart_item_quantity', with: 4
        click_button '更新'
      end

      expect(page).to have_content '商品を更新しました'
    end
  end
end
