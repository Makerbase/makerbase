module OmniauthHelper
  def oauth_sign_in
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      :provider => 'github',
      :uid => '123545',
      :login => 'Sanjay Purswani',
      :name => 'Sanjay Purswani',
      :github_token => '12345',
      :credentials => { :token => "a" },
      :info => {
        :nickname => 'sanjsanj',
        :email => 'sanj@sanj.com',
        :urls => { :GitHub => "https://github.com/sanj" }
      }
    })
    visit root_path
    click_link 'Sign in with Github'
  end

  def oauth_sign_in_2
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      :provider => 'github',
      :uid => '223545',
      :login => 'Bob Bobson',
      :name => 'Bob Bobson',
      :github_token => '22345',
      :credentials => { :token => "b" },
      :info => {
        :nickname => 'bob',
        :email => 'bob@sanj.com',
        :urls => { :GitHub => "https://github.com/bob" }
      }
    })
    visit root_path
    click_link 'Sign in with Github'
  end

  def oauth_sign_out
    OmniAuth.config.mock_auth[:github] = nil
  end
end
