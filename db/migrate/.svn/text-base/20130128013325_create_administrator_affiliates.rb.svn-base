# -*- encoding : utf-8 -*-
class CreateAdministratorAffiliates < ActiveRecord::Migration
  def change
    create_table :administrator_affiliates do |t|
      t.references :administrator
      t.references :affiliate

      t.timestamps
    end
    add_index :administrator_affiliates, :administrator_id
    add_index :administrator_affiliates, :affiliate_id
  end
end
