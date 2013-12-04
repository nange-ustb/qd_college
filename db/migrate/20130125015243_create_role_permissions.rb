# -*- encoding : utf-8 -*-
class CreateRolePermissions < ActiveRecord::Migration
  def change
    create_table :role_permissions do |t|
      t.references :role
      t.references :permission

      t.timestamps
    end
    add_index :role_permissions, :role_id
    add_index :role_permissions, :permission_id
  end
end
