# -*- encoding : utf-8 -*-
class CreateAdministratorRoles < ActiveRecord::Migration
  def change
    create_table :administrator_roles do |t|
      t.references :administrator
      t.references :role

      t.timestamps
    end
  end
end
