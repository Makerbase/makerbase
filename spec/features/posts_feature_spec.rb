require 'rails_helper'

feature 'posts' do
  include UsersHelper

  before(:each) do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      :provider => 'github',
      :uid => '123545',
      :info => { :email => 'sanj@sanj.com', :name => 'sanj' }
      # etc.
    })
    visit root_path
    click_link 'Sign in with Github'
  end

  after(:each) do
    OmniAuth.config.mock_auth[:github] = nil
  end

  context 'no posts/resources have been added' do
    scenario 'should prompt to add a post' do
      visit '/posts'
      expect(page).to have_content 'No links yet'
      expect(page).to have_link 'Add a link'
    end
  end

  context 'posts/resources have been added' do
    before do
      Post.create(title: 'Ultimate Resource', link: 'www.google.com')
    end
    scenario 'display posts' do
      visit '/posts'
      expect(page).to have_content('Ultimate Resource')
      expect(page).to have_content('www.google.com')
    end
  end

  context 'user adding posts' do
    scenario 'user adds a post' do
      visit '/posts'
      add_post
      expect(page).to have_content('Ultimate Resource')
      expect(page).to have_content('www.google.com')
    end

    scenario 'with tags' do
      visit '/posts'
      add_post
      expect(page).to have_content('ruby')
      expect(page).to have_content('beginner')
    end
  end

  context 'deleting post' do
    before {Post.create title: 'Ultimate Resource', link: 'www.google.com', all_tags: 'ruby, makers, beginner'}

    scenario 'removes a post when a user clicks delete button' do
      visit '/posts'
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

  def add_post(title = 'Ultimate Resource', link = 'www.google.com', tags = 'ruby, makers, beginner')
    click_link 'Add a link'
    fill_in 'Title', with: title
    fill_in 'Link', with: link
    fill_in 'post_all_tags', with: tags
    click_button 'Submit'
  end
end
