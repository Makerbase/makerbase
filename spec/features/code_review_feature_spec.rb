require 'rails_helper'

feature 'code review' do
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
      expect(page).to have_content('Please review my challenge')
      expect(page).not_to have_content 'No reviews yet'
    end
  end

end