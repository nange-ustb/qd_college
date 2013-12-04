# -*- encoding : utf-8 -*-
class CreateExams < ActiveRecord::Migration
  def change
    create_table :exams do |t|
      t.string :level
      t.integer :student_id
      t.integer :correct
      t.integer :incorrect
      t.boolean :pass
      t.boolean :finished,:default=>false

      t.timestamps
    end
    add_index :exams,[:student_id]
    add_index :exams,[:student_id,:level]
  end
end
