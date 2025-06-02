class AddOpenLibraryFieldsToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :read_url, :string
    add_column :books, :has_online_copy, :boolean, default: false, null: false

    # Add an index to improve query performance
    add_index :books, :has_online_copy
  end
end
