class Book < ApplicationRecord
    validates :title, :author, presence: true
    validates :isbn, uniqueness: { allow_nil: true }
  
    has_many :borrowings
    has_many :borrowers, through: :borrowings, source: :user
    has_many :saved_books
    has_many :users_who_saved, through: :saved_books, source: :user
  
    belongs_to :borrower, class_name: 'User', optional: true
  
    # Status can be: 'available', 'borrowed'
    validates :status, inclusion: { in: ['available', 'borrowed'] }
  
    validates :image_url, format: { with: URI::DEFAULT_PARSER.make_regexp, allow_nil: true }
  
    # Optional fields with validations
    validates :page_count, numericality: { only_integer: true, greater_than: 0, allow_nil: true }
    validates :published_date, presence: { allow_nil: true }
    validates :description, length: { maximum: 2000, allow_nil: true }
    validates :read_url, format: { with: URI::DEFAULT_PARSER.make_regexp, allow_nil: true }
  
    before_validation :set_default_status
  
    # Online copy status
    before_save :set_online_copy_status
  
    # Attribute accessors
    attribute :has_online_copy, :boolean, default: false
  
    def available?
      status == 'available'
    end
  
    def borrowed?
      status == 'borrowed'
    end
  
    def borrowed_by?(user)
      current_borrowing&.user == user
    end
  
    def current_borrowing
      borrowings.where(returned_at: nil).first
    end
  
    def borrower
      current_borrowing&.user
    end
  
    private
  
    def set_default_status
      self.status ||= 'available'
    end
  
    def set_online_copy_status
      self.has_online_copy = read_url.present?
      true
    end
  end

