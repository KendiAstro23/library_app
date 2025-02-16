class Book < ApplicationRecord
    validates :title, :author, :isbn, presence: true
    validates :isbn, uniqueness: true
  
    has_many :borrowings
    has_many :users, through: :borrowings
  
    def available?
      borrowings.where(returned_at: nil).empty?
    end
  end
    belongs_to :borrower, class_name: "User", foreign_key: "borrower_id", optional: true
  end
  
  validates :image_url, presence: true  # Ensure image URL exists
  has_many :borrowings
  has_many :users, through: :borrowings

  # Scope to get books that are currently borrowed
  scope :borrowed, -> { joins(:borrowings).where(borrowings: { returned_at: nil }) }
end

