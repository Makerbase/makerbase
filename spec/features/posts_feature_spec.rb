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

    xscenario 'display posts by order of number of likes (descending)' do
      visit posts_path
      within()

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

  xcontext 'deleting post' do
    before {Post.create title: 'Ultimate Resource', link: 'www.google.com', all_tags: 'ruby, makers, beginner'}

    scenario 'removes a post when a user clicks delete button' do
      visit posts_path
      click_button 'Delete'
      expect(page).not_to have_content 'Ultimate Resource'
      expect(page).to have_content 'Post deleted'
    end
  end

  # xcontext 'editing posts' do
  #   before do
  #     Post.create(title: 'Resource', link: 'www.google.com', post_all_tags: 'ruby, makers, beginner')
  #   end

  #   scenario 'let a user edit a restaurant' do
  #     visit '/posts'
  #     click_link 'Edit a link'
  #     fill_in 'title', with: 'Ultimate Resource'
  #     fill_in 'Link', with: 'www.google.com'
  #     fill_in 'post_all_tags', with: 'ruby, makers, beginner'
  #     click_button 'Update'
  #     expect(page).to have_content 'Ultimate Resource'
  #     # expect(current_path).to eq '/posts'
  #   end
  # end
end
