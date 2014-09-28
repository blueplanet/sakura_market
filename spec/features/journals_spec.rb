require 'spec_helper'

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
        background do
          visit root_path
          find(:link, journal.title).click
        end

        scenario '編集・削除リンク表示される' do

          expect(page.current_path).to eq journal_path(journal)
          expect(page).to have_css "a[href='#{edit_journal_path(journal)}']"
          expect(page).to have_link '削除'
        end

        scenario '記事を更新出来る' do
          find(:link, '編集').click

          fill_in 'journal_title', with: '更新後のタイトル'
          fill_in 'journal_body', with: '更新後の内容'

          find("input[value=更新する]").click

          expect(page.current_path).to eq root_path
          expect(page).to have_content '更新後のタイトル'
        end

        scenario '記事を削除出来る' do
          find(:link, '削除').click

          expect(page.current_path).to eq root_path
          expect(page).to_not have_content journal.title
        end
      end
    end
  end
end
