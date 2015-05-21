require 'rails_helper'

feature 'code review' do
  include OmniauthHelper

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

  context 'user requests code review' do
    scenario 'prompts user to fill out form' do
      visit codereviews_path
      click_link 'Request review'
      fill_in 'Title', with: 'Please review my challenge'
      fill_in 'Url', with: 'https://github.com/sanjsanj/gymbuddy'
      click_button 'Submit'
      expect(page).to have_content 'Please review my challenge'
      expect(current_path).to eq codereviews_path
    end
  end

  context 'viewing code review requests' do

    scenario 'visit code reviews path', :js => true do
     visit codereviews_path
     click_link 'Request review'
     fill_in 'Title', with: 'Please review my challenge'
     fill_in 'Url', with: 'https://github.com/sanjsanj/gymbuddy'
     click_button 'Submit'
     click_link 'https://github.com/sanjsanj/gymbuddy'
     expect(current_path).to eq "/sanjsanj/gymbuddy"
    end
  end
end
