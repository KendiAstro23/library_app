# app/models/current.rb
class Current < ActiveSupport::CurrentAttributes
  attribute :user
  attribute :session
end
