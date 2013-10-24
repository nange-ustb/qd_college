# -*- encoding : utf-8 -*-
class CreateAwardRecords < ActiveRecord::Migration
  def change
    create_table :award_records do |t|
      t.string :title
      t.string :code
      t.string :level
      t.integer :user_id
      t.integer :game_chance_id

      t.timestamps
    end
    add_index :award_records,:user_id
    add_index :award_records,:game_chance_id
    add_index :award_records,:code
  end
end
