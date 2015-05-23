require 'rails_helper'

feature 'tagging system' do
  include OmniauthHelper
  include UsersHelper

  before :each do
    oauth_sign_in
    visit '/posts'
    add_post
    add_post('Another Resource', 'www.resources.com', 'tag1, tag2, tag3')
    expect(page).to have_content('Ultimate Resource')
    expect(page).to have_content('Another Resource')
  end

  after :each do
    oauth_sign_out
  end

  scenario 'all tags show up on resources page' do
    expect(page).to have_content 'tag1'
    expect(page).to have_content 'makers'
  end
end