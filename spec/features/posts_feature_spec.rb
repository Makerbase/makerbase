require 'rails_helper'

feature 'posts' do
  context 'no posts/resources have been added' do
    scenario 'should prompt to add a post' do
      visit '/posts'
      expect(page).to have_content 'No links yet'
      expect(page).to have_link 'Add a link'
    end
  end
end
