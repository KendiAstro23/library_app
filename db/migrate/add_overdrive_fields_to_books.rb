class AddOverdriveFieldsToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :overdrive_id, :string
    add_column :books, :download_link, :string
    add_column :books, :format, :string
    add_column :books, :has_online_copy, :boolean, default: false
    
    add_index :books, :overdrive_id
  end
end 