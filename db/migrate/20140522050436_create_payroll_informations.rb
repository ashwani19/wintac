class CreatePayrollInformations < ActiveRecord::Migration
  def change
    create_table :payroll_informations do |t|
      t.integer :employee_id
      t.date :hired_date
      t.date :raise_date
      t.date :termin_date
      t.decimal :raise_amount
      t.text :notes

      t.timestamps
    end
  end
end
