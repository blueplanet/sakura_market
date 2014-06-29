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

  scenario '送付情報を入力し注文すると注文が保存される' do
    fill_in 'order_name', with: 'さくら　太郎'
    fill_in 'order_tel', with: '03-1111-2222'
    fill_in 'order_zipcode', with: '222-1111'
    fill_in 'order_address', with: '東京都品川区大井町２−３−４５５'
    fill_in 'order_delivery_day', with: Order.new.send(:business_days_after, 5).to_s
    select Order.delivery_time.options.first.first, from: 'order_delivery_time'

    click_button I18n.t('orders.new.create')

    expect(page.current_path).to eq root_path

    order = Order.last
    expect(order.postage).not_to be_nil
    expect(order.fee).not_to be_nil
    expect(order.tax).not_to be_nil
    expect(order.total).not_to be_nil

    expect(order.cart).not_to be_nil
    expect(order.cart).to be_checkouted
  end
end
