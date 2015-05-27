module UsersHelper
  def add_post(title = 'Ultimate Resource', link = 'www.google.com', tags = 'ruby, makers, beginner')
    click_link 'Add a link'
    fill_in 'Title', with: title
    fill_in 'Link', with: link
    fill_in 'post_all_tags', with: tags
    click_button 'Submit'
  end

  def add_comment(comments = 'cool link')
    click_link 'Leave Comment'
    fill_in "Comments", with: "cool link"
    click_button 'Add Comment'
  end

  def request_code_review
    visit codereviews_path
    click_link 'Request Review'
    fill_in 'Title', with: 'Please review my challenge'
    fill_in 'Url', with: 'https://github.com/sanjsanj/gymbuddy'
    click_button 'Submit'
  end

  def ask_question(title = 'What is code?', body = 'I have never heard of the word')
    click_link 'Ask a question!'
    fill_in 'question_title', with: title
    fill_in 'question_body', with: body
    click_button 'Ask'
  end
end
