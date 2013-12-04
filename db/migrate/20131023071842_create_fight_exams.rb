# -*- encoding : utf-8 -*-
class CreateFightExams < ActiveRecord::Migration
  def change
    create_table :fight_exams do |t|
      t.references :user
      t.integer :gold_count, :default => 0
      t.integer :success_stage, :default => 0
      t.integer :current_stage, :default => 1
      t.text    :stage_order
      t.string  :status, :default => "new", :comment => "started paused over"
      t.timestamps
    end
  end
end
