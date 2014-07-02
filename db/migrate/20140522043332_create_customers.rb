class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :company_name
      t.string :name
      t.text :address1
      t.text :address2
      t.string :city
      t.string :state
      t.string :county
      t.string :salutation
      t.string :phone1
      t.string :phone2
      t.string :email
      t.string :email_1
      t.string :business

      t.timestamps
    end
  end
end
