class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    # byebug
    @user = User.from_omniauth(request.env["omniauth.auth"])
    # byebug

    if @user.persisted?# && authenticate_organisation
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "github") if is_navigational_format?
    else
      session["devise.github_data"] = request.env["omniauth.auth"]
      redirect_to root_path
      flash[:notice] = 'Github log in failed'
    end

  end

  def authenticate_organisation
    # byebug
    client = Octokit::Client.new :access_token => auth_hash['credentials']['token']
    return client.org_member?(ENV['ORG_NAME'], client.user.login)
  end

  protected

  def auth_hash
    request.env["omniauth.auth"]
  end
end
