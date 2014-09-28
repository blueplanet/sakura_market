require 'spec_helper'

feature 'ゲストは、日記の一覧を確認したい' do
  background do
    FactoryGirl.create_list :journal, 3

    login
    visit root_path
  end

  given(:new_journal) { FactoryGirl.build :journal }

  scenario 'トップページにアクセスすると、日記一覧を確認できる' do
    Journal.first(25).each do |journal|
      expect(page).to have_content journal.title
    end
  end

  scenario '日記を新規出来る' do
    find('a#new-journal').click
    expect(page.current_path).to eq new_journal_path

    fill_in 'journal_title', with: new_journal.title
    fill_in 'journal_body', with: new_journal.body

    find("input[value=登録する]").click

    expect(page.current_path).to eq root_path
    expect(page).to have_content new_journal.title
  end
end
