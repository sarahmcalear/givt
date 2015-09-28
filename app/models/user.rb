class User < ActiveRecord::Base

  acts_as_token_authenticatable

  attr_accessor :reset_password_token
  attr_accessor :reset_password_sent_at
  attr_accessor :password

  before_save :ensure_authentication_token!

  devise :invitable, :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :lockable

  def generate_secure_token_string
    SecureRandom.urlsafe_base64(25).tr('lIO0', 'sxyz')
  end

  # Sarbanes-Oxley Compliance: http://en.wikipedia.org/wiki/Sarbanes%E2%80%93Oxley_Act
  def password_complexity
    if password.present? and not password.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W]).+/)
      errors.add :password, "must include at least one of each: lowercase letter, uppercase letter, numeric digit, special character."
    end
  end

  def password_presence
    password.present? && password_confirmation.present?
  end

  def password_match
    password == password_confirmation
  end

  def ensure_authentication_token!
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  # def generate_authentication_token
  #   loop do
  #     token = generate_secure_token_string
  #     break token unless User.where(authentication_token: token).first
  #   end
  # end

  def reset_authentication_token!
    self.authentication_token = generate_authentication_token
  end


  # user_email = request.headers["X-API-EMAIL"].presence
  # user_auth_token = request.headers["X-API-TOKEN"].presence
end

