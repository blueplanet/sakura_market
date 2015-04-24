require 'spec_helper'

feature 'ユーザは、注文情報を管理したい' do
  background { login }

  feature 'ユーザは、カートにある商品を注文したい' do
    background do
      FactoryGirl.create_list :product, 3

      2.times do
        visit products_path
        all(:link, I18n.t('products.common.add_to_cart')).first.click
      end

      visit products_path
      all(:link, I18n.t('products.common.add_to_cart')).last.click

      find(:link, I18n.t('carts.show.checkout')).click
    end

    scenario 'カートページの注文ボタンをクリックすると、注文ページが表示される' do
      expect(current_path).to eq new_order_path

      expect(find(:css, 'input#order_postage_amount').value).to eql '600'
    end

    scenario '送付情報を入力し注文すると注文が保存される' do
      fill_in 'order_name', with: 'さくら　太郎'
      fill_in 'order_tel', with: '03-1111-2222'
      fill_in 'order_zipcode', with: '222-1111'
      fill_in 'order_address', with: '東京都品川区大井町２−３−４５５'
      fill_in 'order_delivery_day', with: 5.business_days.from_now.to_date.to_s
      select Order.delivery_time.options.first.first, from: 'order_delivery_time'

      click_button I18n.t('orders.new.create')

      expect(page.current_path).to eq root_path

      order = Order.last

      expect(order.cart).not_to be_nil
      expect(order.cart).to be_checkouted
    end
  end

  feature 'ユーザは、注文一覧を確認したい' do
    let!(:orders) { FactoryGirl.create_list :order, 5 }

    scenario 'ユーザは注文一覧を確認できる' do
      visit orders_path

      expect(page).to have_css '.list-group-item', count: 5
    end
  end

  feature 'ユーザは、注文の詳細内容を確認したい' do
    let!(:order) { FactoryGirl.create :order }

    scenario '注文詳細画面に遷移すると詳細を確認できる' do
      visit order_path(order)

      expect(page).to have_css '.panel-heading', text: '送付先'
      expect(page).to have_css '.panel-heading', text: '配送日時'
      expect(page).to have_css '.panel-heading', text: '料金'
    end
  end
end
