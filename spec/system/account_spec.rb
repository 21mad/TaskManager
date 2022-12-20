require 'rails_helper'
require 'spec_helper'
require 'faker'

RSpec.describe 'User', type: :system do
  before :each do
    create_accs
    User.create(username: 'admin', email: 'admin@example.com', password: 'password')
  end
  context 'Account:' do
    before do
      visit '/en/session/login'
      fill_in :username, with: 'admin'
      fill_in :password, with: 'password'
      click_button 'Log in'
      click_link 'Account'
    end

    scenario 'change your nickname' do
      fill_in :user_username, with: '21mad'
      fill_in :user_password, with: 'admin'
      fill_in :user_password_confirmation, with: 'admin'
      click_button 'Update'
      expect(page).to have_content("User was successfully updated.")
      expect(page).to have_content("21mad")
    end

    scenario 'change your password' do
      fill_in :user_username, with: 'admin'
      fill_in :user_password, with: 'new_password'
      fill_in :user_password_confirmation, with: 'new_password'
      click_button 'Update'
      expect(page).to have_content("User was successfully updated.")
      expect(page).to have_content("admin")
    end

		scenario 'cannot delete account if admin' do
      click_button 'Delete this account'
			expect(page).to have_content("You're admin!")
    end

    scenario 'can delete account if user' do
      User.create(username: 'just_user', email: 'just_user@mail.ru' , password: 'password')
      click_link 'Logout'
      fill_in :username, with: 'just_user'
      fill_in :password, with: 'password'
      click_button 'Log in'
      click_link 'Account'
      click_button 'Delete this account'
			expect(page).to have_content("Account was successfully deleted.")
    end

  end
end


def create_accs
  5.times{ User.create(username: Faker::Lorem.name, email: (Faker::Lorem.word + '@mail.ru') , password: 'password') }
  User.create(username: 'just_user1', email: 'just_user1@mail.ru' , password: 'password')
  User.create(username: 'just_user2', email: 'just_user2@mail.ru' , password: 'password')
  User.create(username: 'just_user3', email: 'just_user3@mail.ru' , password: 'password')
end