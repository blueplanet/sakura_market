require 'rails_helper'

feature 'ゲストは、商品の情報を確認したい' do
  let!(:products) { FactoryGirl.create_list :product, 5 }

  scenario '商品一覧ページにアクセスすると、商品一覧を確認できる' do
    visit products_path

    expect(page).to have_css '.product-item', count: 5

    product = products.first
    click_link product.name

    expect(page.current_path).to eq product_path(product)
  end
end
