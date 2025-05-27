# app/models/current.rb
class Current < ActiveSupport::CurrentAttributes
  attribute :user  # ✅ Defines a `user` attribute
end
