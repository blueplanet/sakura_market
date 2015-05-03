require 'rails_helper'

feature 'ゲストは、日記の一覧を確認したい' do
  background do
    FactoryGirl.create_list :journal, 3

    visit root_path
  end

  given(:new_journal) { FactoryGirl.build :journal }

  scenario 'トップページにアクセスすると、日記一覧を確認できる' do
    Journal.first(25).each do |journal|
      expect(page).to have_content journal.title
    end
  end

  scenario '日記の新規リンク表示されない' do
    expect(page).not_to have_css 'a#new_journal'
  end

  scenario '一覧ページの日記タイトルをクリックすると、詳細ページに遷移される' do
    journal = Journal.last

    find(:link, journal.title).click
    expect(page.current_path).to eq journal_path(journal)
  end

  context 'ログインユーザの場合' do
    given(:user) { FactoryGirl.create :user }
    background { login user }

    scenario '日記を新規出来る' do
      find('a#new-journal').click
      expect(page.current_path).to eq new_journal_path

      fill_in 'journal_title', with: new_journal.title
      fill_in 'journal_body', with: new_journal.body

      find("input[value=登録する]").click

      expect(page.current_path).to eq root_path
      expect(page).to have_content new_journal.title
    end

    feature '日記の詳細を確認出来る' do
      context '自分の記事の場合' do
        given!(:journal) { FactoryGirl.create :journal, user: user }
        background { visit root_path }

        scenario '編集・削除リンク表示される' do
          find(:link, journal.title).click

          expect(page.current_path).to eq journal_path(journal)
          expect(page).to have_css "a[href='#{edit_journal_path(journal)}']"
          expect(page).to have_link '削除'
        end

        scenario '編集リンクをクリックすると、編集ページに遷移できる' do
          find(:link, journal.title).click

          click_link '編集'
          expect(page.current_path).to eq edit_journal_path(journal)
        end

        scenario '削除リンクをクリックすると、記事を削除できる' do
          find(:link, journal.title).click
          click_link '削除'

          expect(page.current_path).to eq journals_path
          expect(page).not_to have_content journal.title
        end
      end
    end

    feature '日記を編集できる' do
      given!(:journal) { FactoryGirl.create :journal, user: user }
      given(:new_journal) { FactoryGirl.build :journal }
      background { visit edit_journal_path(journal) }

      scenario '内容を更新し保存を押すと日記が更新される' do
        fill_in 'journal_title', with: new_journal.title
        fill_in 'journal_body', with: new_journal.body

        click_on '更新する'

        expect(page.current_path).to eq root_path
        expect(page).to have_content new_journal.title
        expect(page).not_to have_content journal.title
      end
    end
  end
end
