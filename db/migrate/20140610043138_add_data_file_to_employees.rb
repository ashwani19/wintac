class AddDataFileToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :doc_or_image, :binary
    add_column :employees, :filename, :string
    add_column :employees, :mime_type, :string
  end
end
