require 'rails_helper'

feature 'posts' do
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
      p Post.all
      visit '/posts'
      expect(page).to have_content('Ultimate Resource')
      expect(page).to have_content('www.google.com')
    end
  end

  context 'user adding posts' do
    scenario 'user adds a post' do
      visit '/posts'
      click_link 'Add a link'
      fill_in 'Title', with: 'Ultimate Resource'
      fill_in 'Link', with: 'www.google.com'
      click_button 'Submit'
      expect(page).to have_content('Ultimate Resource')
      expect(page).to have_content('www.google.com')
    end

    scenario 'with tags' do
      visit '/posts'
      click_link 'Add a link'
      fill_in 'Title', with: 'Ultimate Resource'
      fill_in 'Link', with: 'www.google.com'
      fill_in 'post_all_tags', with: 'ruby, makers, beginner'
      click_button 'Submit'
      expect(page).to have_content('ruby')
      expect(page).to have_content('beginner')
    end
  end
end