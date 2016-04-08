class User < ActiveRecord::Base
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  has_many :authentications, :dependent => :destroy
  accepts_nested_attributes_for :authentications

  authenticates_with_sorcery!

  def generate_auth_token
    if Rails.env.development? && email.include?('bingsteup@gmail.com')
      return self.auth_token = 'testtest'
    end
    if Rails.env.development? && email.include?('sping.nl')
      return self.auth_token = 'spingsping'
    end
    self.auth_token = generate_unique_token
  end

  def logout!
    update(auth_token: nil)
  end

  private

  def password_update?
    password.present?
  end

  def generate_unique_token
    token = SecureRandom.uuid.delete('-')
    token = generate_unique_token if User.exists?(auth_token: token)
    token
  end
end
