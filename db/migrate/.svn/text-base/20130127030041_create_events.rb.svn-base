# -*- encoding : utf-8 -*-
class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :action,:limit => 50,:null => false
      t.string :subject,:limit => 50,:null => false
      t.string :desc,:limit => 50,:null => false

      t.timestamps
    end
  end
end
