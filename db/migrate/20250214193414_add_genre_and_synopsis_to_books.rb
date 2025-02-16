class AddGenreAndSynopsisToBooks < ActiveRecord::Migration[8.0]
  def change
    add_column :books, :genre, :string
    add_column :books, :synopsis, :text
  end
end
