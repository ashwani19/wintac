class AddZipToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :zip, :string
  end
end
