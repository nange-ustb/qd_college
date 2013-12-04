# -*- encoding : utf-8 -*-
class CreateRegulations < ActiveRecord::Migration
  def change
    create_table :regulations do |t|
      t.references :taxon
      t.text       :description
      t.integer    :position

      t.timestamps
    end
  end
end
