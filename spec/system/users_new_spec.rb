require 'rails_helper'
RSpec.describe 'Registration', type: :system do
  feature 'User registers' do
    scenario 'with valid details' do
      visit '/users/new'

      fill_in :user_username, with: 'new_username'
      fill_in :user_email, with: 'tester@example.tld'
      fill_in :user_password, with: 'test-password'
      fill_in :user_password_confirmation, with: 'test-password'
      click_button 'Registration'

      expect(current_path).to eq '/en'
      expect(page).to have_content(
        'Welcome!'
      )
    end

    context 'with invalid details' do
      before do
        visit new_user_path
      end

      scenario 'blank fields' do
        fill_in :user_username, with: ''
        fill_in :user_email, with: ''
        fill_in :user_password, with: ''
        fill_in :user_password_confirmation, with: ''

        click_button 'Registration'

        expect(page).to have_content("6 errors")
      end

      scenario 'incorrect password confirmation' do
        fill_in :user_username, with: 'new_user'
        fill_in :user_email, with: 'tester@example.tld'
        fill_in :user_password, with: 'test-password'
        fill_in :user_password_confirmation, with: 'not-test-password'
        click_button 'Registration'

        expect(page).to have_content("1 error")
      end

      scenario 'already registered email' do
        User.create(username: 'cool_user', email: 'user@example.com', password: 'password')

        fill_in :user_username, with: 'new_user'
        fill_in :user_email, with: 'user@example.com'
        fill_in :user_password, with: 'test-password'
        fill_in :user_password_confirmation, with: 'test-password'
        click_button 'Registration'

        expect(page).to have_content("1 error")
      end

      scenario 'invalid email' do
        fill_in :user_username, with: 'new_user'
        fill_in :user_email, with: 'someexample_tld'
        fill_in :user_password, with: 'password'
        fill_in :user_password_confirmation, with: 'password'
        click_button 'Registration'

        expect(page).to have_content("1 error")
      end
    end
  end
end