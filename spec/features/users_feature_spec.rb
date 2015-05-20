require 'rails_helper'

feature 'users' do
  context 'when not signed in' do
    scenario 'should see link to sign in' do
      visit '/'
      expect(page).to have_link 'Sign in with Github'
    end

    scenario 'redirected to home when trying to access other pages' do
      visit '/posts'
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
    end

    after(:each) do
      OmniAuth.config.mock_auth[:github] = nil
    end

    scenario 'can see posts page' do
      visit root_path
      click_link 'Sign in with Github'
      visit posts_path
    end
  end
end
