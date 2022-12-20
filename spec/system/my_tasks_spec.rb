require 'rails_helper'
require 'spec_helper'

RSpec.describe 'Folders', type: :system do
  before :each do
    User.create(username: 'admin', email: 'admin@example.com', password: 'password')
  end
  context 'My Tasks:' do
    before do 
      visit '/en/session/login'
      fill_in :username, with: 'admin'
      fill_in :password, with: 'password'
      click_button 'Log in'
      click_link 'My Tasks'
    end

    feature 'Creating new folder' do
      before do
        click_button 'Create'
        fill_in :folder_name, with: 'valid name'
        fill_in :folder_description, with: 'description'
        fill_in :folder_red, with: 1
        fill_in :folder_orange, with: 3
        fill_in :folder_yellow, with: 6
      end

      scenario 'create new folder with valid params' do
        click_button 'Create a Folder'
        expect(page).to have_content("Folder was successfully created.")
        expect(page).to have_content("valid name")
      end

      scenario 'create new folder with empty name' do
        fill_in :folder_name, with: ''
        click_button 'Create a Folder'
        expect(page).to have_content("Folder name cannot be empty.")
      end

      scenario 'create new folder with wrong colors' do
        fill_in :folder_red, with: 4
        fill_in :folder_orange, with: 2
        fill_in :folder_yellow, with: 6
        click_button 'Create a Folder'
        expect(page).to have_content("Wrong color settings.")
      end
    end

    feature 'Deleting folder' do
      before do
        click_button 'Create'
        fill_in :folder_name, with: 'valid name'
        fill_in :folder_description, with: 'description'
        fill_in :folder_red, with: 1
        fill_in :folder_orange, with: 3
        fill_in :folder_yellow, with: 6
        click_button 'Create a Folder'
      end
      
      scenario 'delete a folder' do
        first(".bi > img").click
        click_button 'Delete this folder!'
        expect(page).to have_content("Folder was successfully destroyed.")
      end
    end

    feature 'Tasks' do 
      before do
        click_button 'Create'
        fill_in :folder_name, with: 'valid name'
        fill_in :folder_description, with: 'description'
        fill_in :folder_red, with: 1
        fill_in :folder_orange, with: 3
        fill_in :folder_yellow, with: 6
        click_button 'Create a Folder'
        first('.nav-link > a:nth-child(2)').click
      end

      scenario 'adding new task with valid params' do
        fill_in :task_title, with: 'test_task'
        fill_in :task_deadline, with: DateTime.current.strftime("%m%d%Y\t%I%M%P")
        click_button 'Add task'
        expect(page).to have_content("test_task")
      end

      scenario 'adding new task with empty title' do
        fill_in :task_title, with: ''
        fill_in :task_deadline, with: DateTime.current.strftime("%m%d%Y\t%I%M%P")
        click_button 'Add task'
        expect(page).to have_content("The task title and deadline cannot be empty :(")
      end

      scenario 'adding new task with empty deadline' do
        fill_in :task_title, with: 'test_task'
        click_button 'Add task'
        expect(page).to have_content("The task title and deadline cannot be empty :(")
      end

      scenario 'delete task' do
        fill_in :task_title, with: 'test_task'
        fill_in :task_deadline, with: DateTime.current.strftime("%m%d%Y\t%I%M%P")
        click_button 'Add task'
        find('#row1 .button_to img').click
        expect(page).to have_content("This folder is empty :(")
      end
    end
  end
end