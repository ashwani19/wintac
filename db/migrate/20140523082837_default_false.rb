class DefaultFalse < ActiveRecord::Migration
  def up
  	change_column :users, :is_active, :boolean, :default => false
  end

  def down
  end
end
