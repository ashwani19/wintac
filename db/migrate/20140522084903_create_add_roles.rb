class CreateAddRoles < ActiveRecord::Migration
  def change
    create_table :add_roles do |t|
      t.string :name
      t.text :role_desc

      t.timestamps
    end
  end
end
