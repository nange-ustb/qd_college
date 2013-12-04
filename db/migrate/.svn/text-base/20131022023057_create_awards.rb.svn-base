# -*- encoding : utf-8 -*-
class CreateAwards < ActiveRecord::Migration
  def change
    create_table :awards do |t|
      t.string :code,null: false
      t.string :title,null: false
      t.float :probability,null: false
      t.integer :count,null: false
      t.integer :game_id,null: false

      t.timestamps
    end
    add_index :awards,:code
  end
end
