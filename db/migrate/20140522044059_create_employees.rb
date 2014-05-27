class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :last_name
      t.string :first_name
      t.string :mid_name
      t.text :address
      t.string :city
      t.string :state
      t.string :county
      t.string :phone
      t.string :phone_1
      t.integer :ss_no
      t.datetime :dob
      t.string :email

      t.timestamps
    end
  end
end
