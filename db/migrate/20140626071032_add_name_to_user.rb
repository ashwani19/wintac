class AddNameToUser < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :addres, :text
    add_column :users, :user_type, :string
    add_column :users, :last_name, :string
    add_column :users, :is_active, :boolean
    add_column :users, :account, :integer
  end
end
