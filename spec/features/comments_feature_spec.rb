require 'rails_helper'

feature 'comments' do

  include OmniauthHelper
  include UsersHelper

  before(:each) do
    oauth_sign_in
  end

  after(:each) do
    oauth_sign_out
  end


  before {Post.create title: 'Ultimate Resource', link: 'www.google.com', all_tags: 'ruby, makers, beginner'}

  scenario 'allow users to leave a comment on a post' do
    visit posts_path
    click_link "Comments:"
    click_link 'Leave Comment'
    fill_in "Comments", with: "cool link"
    click_button 'Add Comment'

    expect(current_path).to eq '/posts/1'
    expect(page).to have_content('cool link')
  end

  # scenario "allow users to delete a comment on a post" do
  #   visit posts_path
  #   click_link 'Ultimate Resource'
  #   click_link 'Leave Comment'
  #   fill_in "Comments", with: "cool link"
  #   click_button 'Add Comment'
  #   click_button 'Delete Comment'
  #   expect(current_path).to eq "/posts/#{Post.last.id}"
  #   expect(page).not_to have_content "cool link"
  # end

  # scenario 'allow users to edit a comment on a post' do
  #   visit posts_path
  #   click_link 'Ultimate Resource'

  #   click_link 'Leave Comment'
  #   fill_in "Comments", with: "cool link"
  #   click_button 'Add Comment'

  #   click_link 'Edit Comment'
  #   fill_in 'Comments', with: 'even better link'
  #   click_button 'Update'
  #   expect(page).to have_content 'even better link'
  # end
end
