require 'spec_helper'

feature 'ユーザは、カートにある商品を注文したい' do
  background do
    FactoryGirl.create_list :product, 3

    login

    2.times do
      visit root_path
      all(:link, I18n.t('products.common.add_to_cart')).first.click
    end

    visit root_path
    all(:link, I18n.t('products.common.add_to_cart')).last.click

    find(:link, I18n.t('carts.show.checkout')).click
  end

  scenario 'カートページの注文ボタンをクリックすると、注文ページが表示される' do
    expect(current_path).to eq new_order_path

    expect(find(:css, 'input#order_postage').value).to eql '600'
  end
end
