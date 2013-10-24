# -*- encoding : utf-8 -*-
class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :title
      t.string :link
      t.text :body
      t.string :desc
      t.integer :position,:default=>0
      t.string :type
      t.string :viewable_type
      t.integer :viewable_id

      t.timestamps
    end
    add_index(:assets, [:viewable_type,:viewable_id,:type],unique: true)
  end
  
end
