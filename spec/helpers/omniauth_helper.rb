module OmniauthHelper
  def oauth_sign_in
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      :provider => 'github',
      :uid => '123545',
      :info => { :login => 'Sanjay Purswani', :github_token => '12345' }
    })
    visit root_path
    click_link 'Sign in with Github'
  end

  def oauth_sign_out
    OmniAuth.config.mock_auth[:github] = nil
  end
end
