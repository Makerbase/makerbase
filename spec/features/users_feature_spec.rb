require 'rails_helper'

feature 'users' do
  include UsersHelper
  include OmniauthHelper

  context 'when not signed in' do
    scenario 'should see link to sign in' do
      visit root_path
      expect(page).to have_link 'Sign in with Github'
    end

    scenario 'redirected to home when trying to access other pages' do
      visit posts_path
      expect(current_path).to eq '/'
    end

    scenario 'should not see link to Resources' do
      visit root_path
      expect(page).not_to have_link 'Resources'
    end

    scenario 'should not be able to delete resources' do
      visit '/posts/new'
      expect(current_path).to eq '/users/sign_in'
    end
  end

  context 'when signed in' do

    before(:each) do
      oauth_sign_in
    end

    after(:each) do
      oauth_sign_out
    end

    scenario 'should see link to resources' do
      expect(page).to have_link 'Resources'
    end

    scenario 'should not see link to sign in' do
      expect(page).not_to have_link 'Sign in with Github'
    end

    scenario 'can go to resources page' do
      click_link 'Resources'
      expect(current_path).to eq posts_path
    end

    scenario 'can add a post/resource' do
      click_link 'Resources'
      add_post
      expect(page).to have_content('Ultimate Resource')
      expect(page).to have_content('www.google.com')
      expect(page).to have_content('ruby, makers, beginner')
    end

    scenario 'can only edit posts that he created' do
      Post.create(title: 'resource', link: 'www.link.com', all_tags: 'makers, code')
      click_link 'Resources'
      expect(page).to have_content('www.link.com')
      click_link 'Edit'
      fill_in 'Title', with: 'Title has been changed'
      click_button 'Update'
      expect(page).to have_content('Cannot edit a post you haven\'t created')
    end

    scenario 'can only delete post that he created' do
      Post.create(title: 'resource', link: 'www.link.com', all_tags: 'makers, code')
      click_link 'Resources'
      expect(page).to have_content('www.link.com')
      click_button 'Delete'
      expect(page).to have_content('www.link.com')
      expect(page).to have_content('Cannot delete a post you haven\'t created')
    end

    scenario 'can only edit comments that he created' do
      post = Post.create(title: 'Ruby', link: 'www.link.com', all_tags: 'makers, code')
      Comment.create(comments: 'cool link', post_id: post.id)
      click_link 'Resources'
      click_link 'Ruby'
      expect(page).to have_content('www.link.com')
      click_link 'Edit Comment'
      expect(page).to have_content('Cannot edit a comment you haven\'t created')
    end
  end
end
