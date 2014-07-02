class AddEmpIdToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :emp_id, :integer
    add_column :employees, :emp_type, :string
    add_column :employees, :notes, :text 
    add_column :employees, :devision,:string
    add_column :employees, :hire_date, :date
    add_column :employees, :termination_date, :date
    add_column :employees, :raise_date, :date
    add_column :employees, :raise_amount, :decimal
  end
end
