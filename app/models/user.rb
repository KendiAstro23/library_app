class User < ApplicationRecord
  has_secure_password
  
  has_many :borrowings
  has_many :books, through: :borrowings
  # Constants
  MIN_PASSWORD_LENGTH = 6
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  # Validations
  validates :name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :email_address, presence: true, 
                            uniqueness: { case_sensitive: false },
                            format: { with: VALID_EMAIL_REGEX }
  validates :password, length: { minimum: MIN_PASSWORD_LENGTH },
                       allow_nil: true  # Allow nil for updates without password change
  validates :password_confirmation, presence: true, on: :create

  has_many :borrowed_books, class_name: "Book", foreign_key: "borrower_id"

  # Callbacks
  before_save :downcase_email_address

  private

  # Ensure email is always stored in lowercase
  def downcase_email_address
    email_address.downcase!
  end
end
