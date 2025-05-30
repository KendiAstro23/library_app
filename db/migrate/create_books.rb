class CreateBooks < ActiveRecord::Migration[7.0]
    def change
      create_table :books do |t|
        t.string :title
        t.string :author
        t.string :isbn
        t.string :image_url
        t.boolean :borrowed, default: false
  
        t.timestamps
      end
    end
  end