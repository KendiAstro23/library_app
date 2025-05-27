class Borrowing < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :due_date, presence: true

  before_validation :set_due_date, on: :create

  private

  def set_due_date
    self.due_date ||= 2.weeks.from_now

  validates :book_id, :user_id, presence: true
  validate :book_must_be_available, on: :create


  before_create :set_due_date

  private

    def set_due_date
    self.due_date ||= borrowed_at ? borrowed_at + 2.weeks : Time.current + 2.weeks
  end
end

  def book_must_be_available
    errors.add(:book, "is already borrowed") unless book.available?
  end
end
