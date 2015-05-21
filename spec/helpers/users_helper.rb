module UsersHelper
  def add_post(title = 'Ultimate Resource', link = 'www.google.com', tags = 'ruby, makers, beginner')
    click_link 'Add a link'
    fill_in 'Title', with: title
    fill_in 'Link', with: link
    fill_in 'post_all_tags', with: tags
    click_button 'Submit'
  end

  def request_code_review
    visit codereviews_path
    click_link 'Request review'
    fill_in 'Title', with: 'Please review my challenge'
    fill_in 'Url', with: 'https://github.com/sanjsanj/gymbuddy'
    click_button 'Submit'
  end
end
