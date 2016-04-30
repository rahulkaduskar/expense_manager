# user data
class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :omniauthable

  validates :name, presence: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates_confirmation_of :password

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(provider:  access_token.provider,
      uid: access_token.uid).first
    return user if user
    registered_user = User.where(email: access_token.info.email).first
    return registered_user if registered_user
    User.create(name: data['name'],
      provider: access_token.provider, email: data['email'],
      uid: access_token.uid,
      password: Devise.friendly_token[0, 20])
  end

  def self.find_by_email_id(email)
    User.where(["email = ?",email]).first
  end
end
