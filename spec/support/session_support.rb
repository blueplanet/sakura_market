require 'rails_helper'

def login(user = FactoryGirl.create(:user) )
  visit new_user_session_path

  fill_in 'user_email', with: user.email
  fill_in 'user_password', with: user.password

  click_button 'ログインする'
end
