# -*- encoding : utf-8 -*-
class CreateExamRecords < ActiveRecord::Migration
  def change
    create_table :exam_records do |t|
      t.integer :student_id
      t.integer :user_id
      t.integer :correct,:default=>0
      t.string :level
      t.integer :exam_count,:default=>0
      t.boolean :pass,:default=>false

      t.timestamps
    end
    add_index :exam_records,[:user_id,:level]
    add_index :exam_records,[:student_id,:level]
  end
end
