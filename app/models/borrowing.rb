class Borrowing < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :book_id, :user_id, :due_date, presence: true
  validate :book_must_be_available, on: :create

  before_create :set_due_date

  private

  def set_due_date
    self.due_date ||= 2.weeks.from_now
  end

  def book_must_be_available
    errors.add(:book, "is already borrowed") unless book.available?
  end
end
