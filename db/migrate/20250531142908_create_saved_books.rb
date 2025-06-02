class CreateSavedBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :saved_books do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end

    add_index :saved_books, [:user_id, :book_id], unique: true
  end
end
