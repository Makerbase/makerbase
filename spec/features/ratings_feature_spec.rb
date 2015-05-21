require 'rails_helper'

feature 'ratings system (likes and dislikes)' do
  include UsersHelper
  include OmniauthHelper

  before :each do
    oauth_sign_in
  end

  after :each do
    oauth_sign_out
  end

  context 'likes a resource, which updates like count by one' do
    scenario 'user rates resource' do
    visit '/posts'
    add_post
    expect(page).to have_content('Ultimate Resource')
    click_button 'Like'
    expect(page).to have_content('Likes: 1')
    end
  end
end