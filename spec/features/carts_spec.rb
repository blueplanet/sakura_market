require 'spec_helper'

feature 'ユーザは、自分のカートを管理したい' do
  background do
    FactoryGirl.create_list :product, 10

    sign_in
    visit root_path
  end

  given(:product) { Product.find_by display_no: 9 }

  scenario 'カタログページで商品をカートに追加出来る' do
    first(:css, '.thumbnail') do
      click 'カートに追加'
    end

    expect(page).to have_content product.name
  end
end
