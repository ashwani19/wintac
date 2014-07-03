class Renameuseraddress < ActiveRecord::Migration
  def self.up
    rename_column :users, :addres, :address
  end

  def self.down
    # rename back if you need or do something else or do nothing
  end
end
