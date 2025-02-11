class User < ApplicationRecord
  has_many :borrowings
  has_many :books, through: :borrowings

  # Include default authentication methods
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
end