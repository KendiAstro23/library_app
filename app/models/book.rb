class Book < ApplicationRecord
<<<<<<< HEAD
    validates :title, :author, :isbn, presence: true
    validates :isbn, uniqueness: true
  
    has_many :borrowings
    has_many :users, through: :borrowings
  
    def available?
      borrowings.where(returned_at: nil).empty?
    end
  end
=======
    belongs_to :borrower, class_name: "User", foreign_key: "borrower_id", optional: true
  end
  
>>>>>>> bc5036a (Dashboard, borrowing page)
