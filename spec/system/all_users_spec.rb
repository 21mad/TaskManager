require 'rails_helper'
require 'spec_helper'
require 'faker'

RSpec.describe 'Users', type: :system do
  before :each do
    create_accs
    User.create(username: 'admin', email: 'admin@example.com', password: 'password')
  end
  context 'All Users:' do
    before do
      visit '/en/session/login'
      fill_in :username, with: 'admin'
      fill_in :password, with: 'password'
      click_button 'Log in'
    end

    scenario 'admin can see user list' do
      click_link 'All Users'
      expect(page).to have_content("User list")
      expect(page).to have_content("User name: admin")
    end

    scenario 'admin can see users accounts' do
      click_link 'All Users'
      first(".user_link").click
      expect(page).to have_content('User Information')
    end

    scenario 'user cannot see user list' do
      User.create(username: 'just_user', email: 'just_user@mail.ru' , password: 'password')
      click_link 'Logout'
      fill_in :username, with: 'just_user'
      fill_in :password, with: 'password'
      click_button 'Log in'
	    expect(page).to_not have_content("All Users")
    end

  end
end


def create_accs
  5.times{ User.create(username: Faker::Lorem.name, email: (Faker::Lorem.word + '@mail.ru') , password: 'password') }
  User.create(username: 'just_user1', email: 'just_user1@mail.ru' , password: 'password')
  User.create(username: 'just_user2', email: 'just_user2@mail.ru' , password: 'password')
  User.create(username: 'just_user3', email: 'just_user3@mail.ru' , password: 'password')
end