# -*- encoding : utf-8 -*-
class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas,:id => false do |t|
      t.string :name
      t.integer :code

      t.timestamps
    end
  end
end
