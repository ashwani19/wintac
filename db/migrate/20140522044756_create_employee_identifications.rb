class CreateEmployeeIdentifications < ActiveRecord::Migration
  def change
    create_table :employee_identifications do |t|
      t.integer :type_id
      t.string :employee_id
      t.string :division
      t.string :location

      t.timestamps
    end
  end
end
