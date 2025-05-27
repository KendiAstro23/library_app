
class Borrowing < ApplicationRecord
  belongs_to :user
<<<<<<< HEAD
  belongs_to :book

  validates :due_date, presence: true

  before_validation :set_due_date, on: :create

  private

  def set_due_date
    self.due_date ||= 2.weeks.from_now
=======

  validates :book_id, :user_id, presence: true
  validate :book_must_be_available, on: :create

  before_create :set_due_date

  def set_due_date
    self.due_date = 2.weeks.from_now
  end

  def book_must_be_available
    errors.add(:book, "is already borrowed") unless book.available?
>>>>>>> c3c3bf0 (Improved README)
  end
end
