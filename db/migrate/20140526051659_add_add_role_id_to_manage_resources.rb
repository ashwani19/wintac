class AddAddRoleIdToManageResources < ActiveRecord::Migration
  def change
    add_column :manage_resources, :add_role_id, :integer
  end
end
