require 'rails_helper'

feature 'code review' do
  include OmniauthHelper
  include UsersHelper

  before(:each) do
    oauth_sign_in
  end

  after(:each) do
    oauth_sign_out
  end

  context 'no review requests have been added' do
    scenario 'should display a button to add a review' do
      visit codereviews_path
      expect(page).to have_content 'No reviews yet'
      expect(page).to have_link 'Request review'
    end
  end

  context 'review request has been added' do

    before do
      Codereview.create(title: 'Please review my challenge')
    end

    scenario 'should display review request' do
      visit codereviews_path
      expect(page).to have_content 'Please review my challenge'
      expect(page).not_to have_content 'No reviews yet'
    end
  end

  context 'user submits request for code review' do
    scenario 'displays the request' do
      request_code_review
      expect(page).to have_content 'Please review my challenge'
      expect(current_path).to eq codereviews_path
    end

    xscenario 'has URL for repository to be reviewed', :js => true do
      visit root_path
      click_link 'Sign in with Github'
      request_code_review
      click_link 'https://github.com/sanjsanj/gymbuddy'
      expect(current_path).to eq "/sanjsanj/gymbuddy"
    end
  end
end
