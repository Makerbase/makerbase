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
    scenario 'when there are no questions' do
      click_link 'Forum'
      expect(page).to have_content 'Ask a question!'
    end

    scenario 'when there are questions' do
      click_link 'Forum'
      click_link 'Ask a question!'
      fill_in 'question_title', with: 'What is Ruby?'
      click_button 'Ask'
      expect(page).to have_content 'What is Ruby?'
    end

    scenario 'questions can be deleted' do
      click_link 'Forum'
      ask_question
      expect(page).to have_content 'What is code?'
      click_link 'Delete Question'
      expect(page).not_to have_content 'What is code?'
      expect(current_path).to eq '/forum'
    end

    scenario 'questions can be edited' do
      click_link 'Forum'
      ask_question
      click_link 'Edit Question'
      fill_in 'question_title', with: 'Just changed this'
      click_button 'Ask'
      expect(page).to have_content('Just changed this')
    end

    scenario 'user answers question' do
      click_link 'Forum'
      ask_question
      click_link 'Answer'
      fill_in 'answer_body', with: 'Code is life'
      click_button 'Post Your Answer'
      expect(page).to have_content('Code is life')
      expect(current_path).to eq "/questions/#{Question.first.id}"
    end

    scenario 'user deletes answer' do
      click_link 'Forum'
      ask_question
      click_link 'Answer'
      fill_in 'answer_body', with: 'Code is life'
      click_button 'Post Your Answer'
      click_button 'Delete Answer'
      expect(page).not_to have_content('Code is life')
    end

    scenario 'user edits answer' do
      click_link 'Forum'
      ask_question
      click_link 'Answer'
      fill_in 'answer_body', with: 'Code is life'
      click_button 'Post Your Answer'
      click_link 'Edit Answer'
      fill_in 'answer_body', with: 'Another answer'
      click_button 'Post Your Answer'
      expect(page).to have_content('Another answer')
    end
  end
end
