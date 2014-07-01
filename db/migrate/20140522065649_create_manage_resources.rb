class CreateManageResources < ActiveRecord::Migration
  def change
    create_table :manage_resources do |t|
      t.integer :user_id
      t.integer :resource_id
      t.integer :role_id

      t.timestamps
    end
  end
end
