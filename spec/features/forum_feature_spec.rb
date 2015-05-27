require 'rails_helper'

feature 'Forum' do
  include UsersHelper
  include OmniauthHelper

  before(:each) do
    oauth_sign_in
  end

  after(:each) do
    oauth_sign_out
  end

  context 'user navigates to Forum page' do
    scenario 'when there are no posts' do
      click_link 'Forum'
      expect(page).to have_content 'Ask a question!'
    end

    scenario 'when there are posts' do
      click_link 'Forum'
      click_link 'Ask a question!'
      fill_in 'question_title', with: 'What is Ruby?'
      click_button 'Ask'
      expect(page).to have_content 'What is Ruby?'
    end

    scenario 'posts can be deleted' do
      click_link 'Forum'
      ask_question
      expect(page).to have_content 'What is code?'
      click_link 'Delete'
      expect(page).not_to have_content 'What is code?'
      expect(current_path).to eq '/forum'
    end
  end
end