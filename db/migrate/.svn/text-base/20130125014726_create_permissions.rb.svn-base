# -*- encoding : utf-8 -*-
class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.string :name
      t.string :code
      t.string :category
      t.integer :uniq_id

      t.timestamps
    end
  end
end
