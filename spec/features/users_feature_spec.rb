require 'rails_helper'

feature 'users' do
  include UsersHelper

  context 'when not signed in' do
    scenario 'should see link to sign in' do
      visit root_path
      expect(page).to have_link 'Sign in with Github'
    end

    xscenario 'redirected to home when trying to access other pages' do
      visit posts_path
      expect(current_path).to eq '/'
    end

    scenario 'should not see link to posts' do
      visit root_path
      expect(page).not_to have_link 'Posts'
    end

    scenario 'should not be able to delete posts' do
      visit '/posts/new'
      expect(current_path).to eq '/'
    end
  end

  context 'when signed in' do
    before(:each) do
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
        :provider => 'github',
        :uid => '123545',
        :info => { :email => 'sanj@sanj.com', :name => 'sanj' }
        # etc.
      })
      visit root_path
      click_link 'Sign in with Github'
    end

    after(:each) do
      OmniAuth.config.mock_auth[:github] = nil
    end

    scenario 'should see link to posts' do
      expect(page).to have_link 'Posts'
    end

    scenario 'should not see link to sign in' do
      expect(page).not_to have_link 'Sign in with Github'
    end

    scenario 'can go to post page' do
      click_link('Posts')
      expect(current_path).to eq posts_path
    end

    scenario 'can add post' do
      click_link 'Posts'
      add_post
      expect(page).to have_content('Ultimate Resource')
      expect(page).to have_content('www.google.com')
      expect(page).to have_content('ruby, makers, beginner')
    end

    scenario 'can edit post' do
      click_link 'Posts'
      add_post
      click_link 'Edit'
      fill_in 'Title', with: 'Title has been changed'
      click_button 'Update'
      expect(page).to have_content('Title has been changed')
    end

  end
end
