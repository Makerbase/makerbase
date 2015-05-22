class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:github]

  validates_presence_of :uid#, :github_token
  validates_uniqueness_of :uid, :name

  def self.from_omniauth(auth)
    p auth
    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      user.password = Devise.friendly_token[0,20]
      # byebug
      user.name = auth.info.name   # uses github username
      user.email = auth.info.email || "#{auth.name.gsub(" ", "")}@mailinator.com"
      user.image = auth.info.image
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.github_data"] && session["devise.github_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
