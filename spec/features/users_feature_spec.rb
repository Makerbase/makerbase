require 'rails_helper'

feature 'users' do
  context 'when not signed in' do
    scenario 'should see link to sign in' do
      visit root_path
      expect(page).to have_link 'Sign in with Github'
    end

    scenario 'redirected to home when trying to access other pages' do
      visit posts_path
      expect(current_path).to eq '/'
    end

    scenario 'should not see link to posts' do
      visit root_path
      expect(page).not_to have_link 'Posts'
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

    scenario 'can see posts page' do
      visit posts_path
      expect(current_path).to eq posts_path
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

  end
end
