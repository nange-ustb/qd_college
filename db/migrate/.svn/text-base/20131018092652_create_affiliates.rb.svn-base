# -*- encoding : utf-8 -*-
class CreateAffiliates < ActiveRecord::Migration
  def change
    drop_table :affiliates if table_exists? :affiliates
    create_table :affiliates , :id => false do |t|
      t.string :name
      t.integer :code

      t.timestamps
    end
  end
end
