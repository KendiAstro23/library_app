class Session < ApplicationRecord
  belongs_to :user

  validates :user_agent, presence: true
  validates :ip_address, presence: true

  before_create do
    self.last_active_at = Time.current
  end

  def active?
    last_active_at >= 2.weeks.ago
  end
end
