module UsersHelper
  def add_post(title = 'Ultimate Resource', link = 'www.google.com', tags = 'ruby, makers, beginner')
    click_link 'Add a link'
    fill_in 'Title', with: title
    fill_in 'Link', with: link
    fill_in 'post_all_tags', with: tags
    click_button 'Submit'
  end
end