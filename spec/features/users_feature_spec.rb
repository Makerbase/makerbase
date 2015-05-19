require 'rails_helper'

feature 'users' do
  context 'when not signed in' do
    scenario 'should see link to sign in' do
      visit '/'
      expect(page).to have_link 'Sign in with Github'
    end
  end
end