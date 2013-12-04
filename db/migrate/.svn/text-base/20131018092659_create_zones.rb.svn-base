# -*- encoding : utf-8 -*-
class CreateZones < ActiveRecord::Migration
  def change
    create_table :zones , :id => false do |t|
      t.integer :code
      t.string :name
      t.integer :parent_id, :default => 0
      t.references :affiliate
      t.references :area

      t.timestamps
    end
    add_index :zones, :affiliate_id
    add_index :zones, :area_id
  end
end
