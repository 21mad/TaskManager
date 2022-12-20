require 'rails_helper'
require 'spec_helper'

RSpec.describe 'Public Folders', type: :system do
  before :each do
    User.create(username: 'admin', email: 'admin@example.com', password: 'password')
  end
  context 'My Tasks:' do
    before do 
      visit '/en/session/login'
      fill_in :username, with: 'admin'
      fill_in :password, with: 'password'
      click_button 'Log in'
      click_link 'Public Tasks'
    end

    feature 'Creating new public folder: ' do
      before do
        click_button 'Create'
        fill_in :public_folder_name, with: 'valid name'
        fill_in :public_folder_description, with: 'description'
        fill_in :public_folder_red, with: 1
        fill_in :public_folder_orange, with: 3
        fill_in :public_folder_yellow, with: 6
      end

      scenario 'create new public_folder with valid params' do
        click_button 'Create a Public folder'
        expect(page).to have_content("Folder was successfully created.")
        expect(page).to have_content("valid name")
      end

      scenario 'create new public_folder with empty name' do
        fill_in :public_folder_name, with: ''
        click_button 'Create a Public folder'
        expect(page).to have_content("Folder name cannot be empty.")
      end

      scenario 'create new public_folder with wrong colors' do
        fill_in :public_folder_red, with: 4
        fill_in :public_folder_orange, with: 2
        fill_in :public_folder_yellow, with: 6
        click_button 'Create a Public folder'
        expect(page).to have_content("Wrong color settings.")
      end
    end

    feature 'Deleting public folder: ' do
      before do
        click_button 'Create'
        fill_in :public_folder_name, with: 'valid name'
        fill_in :public_folder_description, with: 'description'
        fill_in :public_folder_red, with: 1
        fill_in :public_folder_orange, with: 3
        fill_in :public_folder_yellow, with: 6
        click_button 'Create a Public folder'
      end
      
      scenario 'delete a public folder' do
        first(".bi > img").click
        click_button 'Delete this folder!'
        expect(page).to have_content("Folder was successfully destroyed.")
      end
    end

    feature 'Adding and deleting members: ' do
      before do
        click_button 'Create'
        fill_in :public_folder_name, with: 'valid name'
        fill_in :public_folder_description, with: 'description'
        fill_in :public_folder_red, with: 1
        fill_in :public_folder_orange, with: 3
        fill_in :public_folder_yellow, with: 6
        click_button 'Create a Public folder'
        first(".bi > img").click
        User.create(username: 'new_member', email: 'member@example.com', password: 'password')
      end

      scenario 'adding a new member with correct nickname' do
        fill_in :public_folder_new_member_name, with: 'new_member'
        click_button 'Update a Public folder'
        expect(page).to have_content('Folder was successfully updated.')
      end

      scenario 'adding a person which is member already' do
        fill_in :public_folder_new_member_name, with: 'new_member'
        click_button 'Update a Public folder'
        first(".bi > img").click
        fill_in :public_folder_new_member_name, with: 'new_member'
        click_button 'Update a Public folder'
        expect(page).to have_content('User to add is already in member list.')
      end

      scenario 'adding a person with incorrect nickname' do
        fill_in :public_folder_new_member_name, with: 'new_memb eeer'
        click_button 'Update a Public folder'
        expect(page).to have_content('User to add not found.')
      end

      scenario 'deleting a member with correct nickname' do
        fill_in :public_folder_new_member_name, with: 'new_member'
        click_button 'Update a Public folder'
        first(".bi > img").click
        fill_in :public_folder_delete_member_name, with: 'new_member'
        click_button 'Update a Public folder'
        expect(page).to have_content('Folder was successfully updated.')
      end

      scenario 'deleting a member with incorrect nickname' do
        fill_in :public_folder_new_member_name, with: 'new_member'
        click_button 'Update a Public folder'
        first(".bi > img").click
        fill_in :public_folder_delete_member_name, with: 'new_memb eeer'
        click_button 'Update a Public folder'
        expect(page).to have_content('User to delete is not in the list of members.')
      end

    end

    feature 'Tasks: ' do 
      before do
        click_button 'Create'
        fill_in :public_folder_name, with: 'valid name'
        fill_in :public_folder_description, with: 'description'
        fill_in :public_folder_red, with: 1
        fill_in :public_folder_orange, with: 3
        fill_in :public_folder_yellow, with: 6
        click_button 'Create a Public folder'
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