class AddRefCodeToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :ref_code, :string
  end
end
