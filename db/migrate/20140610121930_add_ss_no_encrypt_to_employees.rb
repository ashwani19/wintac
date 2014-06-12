class AddSsNoEncryptToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :ss_no_enc, :string
  end
end
