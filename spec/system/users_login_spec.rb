require 'rails_helper'
RSpec.describe 'Session', type: :system do
  feature 'User logs in and logs out' do
    scenario 'with correct details', js: true do
      User.create(username: 'test_user', email: 'user@example.com', password: 'password')

      visit '/en/session/login'

      fill_in :username, with: 'test_user'
      fill_in :password, with: 'password'
      click_button 'Log in'
      expect(current_path).to eq '/en'
      expect(page).to have_content 'Choose an existing folder or create a new one!'

      click_link 'Logout'
      expect(current_path).to eq '/en/session/login'
      expect(page).to have_content 'To continue, log in to your account:'
    end

    scenario 'Check without register' do
      routes = ['/en', '/en/public_folders', '/en/folders']
      routes.each do |path|
        to_path(path)
      end
    end

    def to_path(path)
      visit path
      expect(current_path).to eq '/en/session/login'
    end
  end
end