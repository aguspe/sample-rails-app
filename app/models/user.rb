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
end
