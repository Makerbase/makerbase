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
      request_code_review
    end

    scenario 'should display review request' do
      visit codereviews_path
      expect(page).to have_content 'Please review my challenge'
      expect(page).not_to have_content 'No reviews yet'
    end
  end

  context 'user submits request for code review' do

    before(:each) do
      request_code_review
    end

    scenario 'displays the request' do
      expect(page).to have_content 'Please review my challenge'
      expect(current_path).to eq codereviews_path
    end

    scenario 'user can see link to delete code review request' do
      expect(page).to have_link 'Delete'
    end

    scenario 'user can delete request' do
      click_link 'Delete'
      expect(page).not_to have_content 'Please review my challenge'
    end

    scenario 'another user cannot see delete link' do
      click_link 'Sign out'
      oauth_sign_in_2
      expect(page).not_to have_link 'Delete'
    end

    scenario 'user can see link to edit code review request' do
      expect(page).to have_link 'Edit'
    end

    scenario 'user can edit request' do
      click_link 'Edit'
      fill_in "Title", with: "omg review me"
      click_button 'Submit'
      expect(page).not_to have_content 'Please review my challenge'
      expect(page).to have_content 'omg review me'
    end

    scenario 'another user cannot see edit link' do
      click_link 'Sign out'
      oauth_sign_in_2
      expect(page).not_to have_link 'Delete'
    end

    scenario 'has URL for repository to be reviewed' do
      expect(page).to have_link 'https://github.com/sanjsanj/gymbuddy'
    end
  end
end
