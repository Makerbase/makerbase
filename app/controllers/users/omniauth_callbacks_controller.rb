class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def github

    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted? && authenticate_organization
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "github") if is_navigational_format?
    else
      session["devise.github_data"] = request.env["omniauth.auth"]
      redirect_to root_path
      flash[:notice] = 'Github log in failed'
    end
  end

  def authenticate_organization
    return true if ENV['RAILS_ENV']="test"
    client = Octokit::Client.new :access_token => auth_hash['credentials']['token']
    return client.organization_public_member?(ENV['ORG_NAME'], client.user.login)
  end

  protected

  def auth_hash
    request.env["omniauth.auth"]
  end
end
