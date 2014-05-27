class AddAccountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :account, :integer
  end
end
