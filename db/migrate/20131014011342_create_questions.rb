# -*- encoding : utf-8 -*-
class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.text :context
      t.string :a
      t.string :b
      t.string :c
      t.string :d
      t.string :e
      t.string :f
      t.string :answer
      t.string :type
      t.string :category

      t.timestamps
    end
  end
end
