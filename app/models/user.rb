class User < ActiveRecord::Base

  has_many :comments, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:github]
  has_many :posts
  has_many :likes, through: :posts

  validates_presence_of :uid#, :github_token
  validates_uniqueness_of :uid, :name

  def self.from_omniauth(auth)
    p auth
    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.nickname   # uses github username
      user.email = auth.email || "#{auth.name.gsub(" ", "")}@mailinator.com" if auth.nickname
    # puts '---' * 20
    # p auth
    # puts '---' * 20
    # p auth.info
    # puts '---' * 20
    # p auth.name
    # puts '---' * 20
    # p auth.info.nickname
    # puts '---' * 20
    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      user.password = Devise.friendly_token[0,20]
      # byebug
      user.name = auth.info.nickname   # uses github username
      user.email = auth.info.email || "#{auth.info.nickname}@mailinator.com"# if auth.name
      user.image = auth.image
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
