require 'rails_helper'

feature 'ratings system (likes and dislikes)' do
  include UsersHelper
  include OmniauthHelper

  before :each do
    oauth_sign_in
    visit posts_path
    add_post
  end

  after :each do
    oauth_sign_out
  end

  context 'user rates resource' do
    scenario 'likes a resource, which updates like count by one' do
      click_link 'Like'
      expect(page).to have_content('1')
    end

    scenario 'user dislikes a resource, which updates dislike count by one' do
      click_link 'Dislike'
      expect(page).to have_content('1')
    end

    scenario 'user dislikes a resource, which he previously liked' do
      click_link 'Like'
      expect(page).to have_content('1')
      click_link 'Dislike'
      expect(page).to have_content('0')
      expect(page).to have_content('1')
    end

    scenario 'user likes a resource, which he previously disliked' do
      click_link 'Dislike'
      expect(page).to have_content('1')
      click_link 'Like'
      expect(page).to have_content('1')
      expect(page).to have_content('0')
    end


  end
end
