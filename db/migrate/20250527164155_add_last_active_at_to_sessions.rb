class AddLastActiveAtToSessions < ActiveRecord::Migration[8.0]
  def change
    add_column :sessions, :last_active_at, :datetime
    add_index :sessions, :last_active_at
  end
end 