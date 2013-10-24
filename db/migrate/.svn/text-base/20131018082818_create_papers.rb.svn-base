# -*- encoding : utf-8 -*-
class CreatePapers < ActiveRecord::Migration
  def change
    create_table :papers do |t|
      t.integer :exam_id
      t.integer :question_id
      t.boolean :finished,:default=>false

      t.timestamps
    end

    add_index :papers,[:exam_id,:question_id]
  end
end
