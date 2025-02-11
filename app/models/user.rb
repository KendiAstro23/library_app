class User < ApplicationRecord
  has_many :borrowings
  has_many :books, through: :borrowings

  # Include default authentication methods
  has_secure_password
end