class User < ApplicationRecord
  EMAIL_FORMAT = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  PASSWORD_FORMAT = /\A(?=.*\d)/x
  before_save { self.email = email.downcase }
  validates :name, :email, presence: true, length: { maximum: 50 }
  validates :bio, presence: false, length: { maximum: 250 }
  validates :email, format: { with: EMAIL_FORMAT, message: 'The email format is example@something.com' },
                    uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 5, message: 'The password is too short' },
                       format: { with: PASSWORD_FORMAT, message: 'The password has the wrong format' }
  has_one_attached :avatar
  attr_accessor :remember_token

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  class << self
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end
end
