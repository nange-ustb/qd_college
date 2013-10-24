# -*- encoding : utf-8 -*-
class CreateGameChances < ActiveRecord::Migration
  def change
    create_table :game_chances do |t|
      t.integer :student_id,:null=>false
      t.integer :game_id,:null=>false
      t.boolean :used,:default=>false

      t.timestamps
    end
    add_index :game_chances,[:student_id]
  end
end
