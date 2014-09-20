require 'spec_helper'

feature 'ゲストは、日記の一覧を確認したい' do
  background do
    FactoryGirl.create_list :journal, 3

    login
  end

  scenario 'トップページにアクセスすると、日記一覧を確認できる' do
    visit root_path

    Journal.first(25).each do |journal|
      expect(page).to have_content journal.title
    end
  end
end
