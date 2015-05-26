require 'rails_helper'

feature 'users' do
  include UsersHelper
  include OmniauthHelper

  context 'when not signed in' do
    scenario 'should see link to sign in' do
      visit root_path
      expect(page).to have_link 'Sign in with Github'
    end

    scenario 'redirected to home when trying to access posts page' do
      visit posts_path
      expect(current_path).to eq root_path
    end

    scenario 'redirected to home when trying to access new posts page' do
      visit new_post_path
      expect(page).to have_content 'Log in'
    end

    scenario 'should not see link to Resources' do
      visit root_path
      expect(page).not_to have_link 'Resources'
    end

    scenario 'should not be able to delete resources' do
      visit new_post_path
      expect(current_path).to eq '/users/sign_in'
    end

    scenario 'sign in fails if not authenticated' do
      visit root_path
      click_link 'Sign in with Github'
      expect(page).to have_content 'Github log in failed'
    end
  end

  context 'when signed in' do

    before(:each) do
      oauth_sign_in
    end

    after(:each) do
      oauth_sign_out
    end

    scenario 'should see link to resources' do
      expect(page).to have_link 'Resources'
    end

    scenario 'should not see link to sign in' do
      expect(page).not_to have_link 'Sign in with Github'
    end

    scenario 'should see link to sign out' do
      expect(page).to have_link 'Sign out'
    end

    scenario 'can sign out' do
      click_link 'Sign out'
      expect(page).to have_link 'Sign in with Github'
    end

    scenario 'can go to resources page' do
      click_link 'Resources'
      expect(current_path).to eq posts_path
    end

    scenario 'can add a post/resource' do
      click_link 'Resources'
      add_post
      expect(page).to have_content('Ultimate Resource')
      expect(page).to have_content('www.google.com')
      expect(page).to have_content('ruby, makers, beginner')
    end

    scenario 'can only edit comments that he created' do
      click_link 'Resources'
      add_post
      click_link 'Ultimate Resource'
      add_comment
      click_link 'Sign out'
      oauth_sign_in_2
      click_link 'Resources'
      click_link 'Ultimate Resource'
      click_link 'Edit Comment'
      expect(page).to have_content('Cannot edit a comment you haven\'t created')
    end

    scenario 'can only delete comments that he created' do
      click_link 'Resources'
      add_post
      click_link 'Ultimate Resource'
      add_comment
      click_link 'Sign out'
      oauth_sign_in_2
      click_link 'Resources'
      click_link 'Ultimate Resource'
      click_button 'Delete Comment'
      expect(page).to have_content('Cannot delete a comment you haven\'t created')
    end
  end
end
