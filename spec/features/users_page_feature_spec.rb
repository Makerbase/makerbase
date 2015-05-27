require 'rails_helper'

feature 'Users page' do
  include UsersHelper
  include OmniauthHelper

  before(:each) do
    oauth_sign_in
  end

  after(:each) do
    oauth_sign_out
  end

  context 'user clicks on Users tab' do
    scenario 'user sees list of all users' do
      visit '/users'
      expect(page).to have_content 'sanjsanj'
    end
  end
end