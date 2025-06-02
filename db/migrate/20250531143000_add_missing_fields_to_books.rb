class AddMissingFieldsToBooks < ActiveRecord::Migration[8.0]
  def change
    add_column :books, :description, :text
    add_column :books, :published_date, :date
    add_column :books, :page_count, :integer
    add_column :books, :categories, :string
  end
end 