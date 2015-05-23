require 'rails_helper'

feature 'ratings system (likes and dislikes)' do
  include UsersHelper
  include OmniauthHelper

  before :each do
    oauth_sign_in
    visit '/posts'
    add_post
    expect(page).to have_content('Ultimate Resource')
  end

  after :each do
    oauth_sign_out
  end

  context 'user rates resource' do
    scenario 'likes a resource, which updates like count by one' do
      click_button 'Like'
      expect(page).to have_content('Likes: 1')
    end

    scenario 'user dislikes a resource, which updates dislike count by one' do
      click_button 'Dislike'
      expect(page).to have_content('Dislikes: 1')
    end

    scenario 'user dislikes a resource, which he previously liked' do
      click_button 'Like'
      expect(page).to have_content('Likes: 1')
      click_button 'Dislike'
      expect(page).to have_content('Likes: 0')
      expect(page).to have_content('Dislikes: 1')
    end

    scenario 'user likes a resource, which he previously disliked' do
      click_button 'Dislike'
      expect(page).to have_content('Dislikes: 1')
      click_button 'Like'
      expect(page).to have_content('Likes: 1')
      expect(page).to have_content('Dislikes: 0')
    end


  end
end
