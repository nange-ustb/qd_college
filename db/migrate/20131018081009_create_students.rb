# -*- encoding : utf-8 -*-
class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.integer :user_id
      t.string :level,:default=>:beginner

      t.timestamps
    end
    add_index :students,[:user_id]
    add_index :students,[:level]
  end
end
