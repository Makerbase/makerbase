require 'rails_helper'

feature 'posts' do
  include OmniauthHelper
  include UsersHelper

  before(:each) do
    oauth_sign_in
  end

  after(:each) do
    oauth_sign_out
  end

  context 'no posts/resources have been added' do
    scenario 'should prompt to add a post' do
      visit posts_path
      expect(page).to have_content 'No links yet'
      expect(page).to have_link 'Add a link'
    end
  end

  context 'posts/resources have been added' do

    before do
      Post.create(title: 'Ultimate Resource', link: 'www.google.com')
    end

    scenario 'display posts' do
      visit posts_path
      expect(page).to have_content('Ultimate Resource')
      expect(page).to have_content('www.google.com')
    end
  end

  context 'user adding posts' do
    scenario 'user adds a post' do
      visit posts_path
      add_post
      expect(page).to have_content('Ultimate Resource')
      expect(page).to have_content('www.google.com')
    end

    scenario 'with tags' do
      visit posts_path
      add_post
      expect(page).to have_content('ruby')
      expect(page).to have_content('beginner')
    end
  end

  context 'deleting post' do

    scenario 'removes a post when a user clicks delete button' do
      visit posts_path
      add_post
      click_link 'Delete'
      expect(page).not_to have_content 'Ultimate Resource'
      expect(page).to have_content 'Post deleted'
    end
  end

  context 'editing posts' do

    scenario 'let a user edit a restaurant' do
      visit posts_path
      add_post
      click_link 'Edit'
      fill_in 'Title', with: 'New Resource'
      fill_in 'Link', with: 'www.google.com'
      click_button 'Update'
      expect(page).to have_content 'New Resource'
    end
  end
end
