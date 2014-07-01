class AddZipToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :zip, :string
  end
end
