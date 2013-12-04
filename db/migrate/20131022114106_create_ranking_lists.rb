# -*- encoding : utf-8 -*-
class CreateRankingLists < ActiveRecord::Migration
  def change
    create_table :ranking_lists do |t|
      t.references :user
      t.references :fight_exam
      t.string     :type
      t.integer    :stage, :default => 0
      t.integer    :gold_count, :default => 0
      t.integer    :position

      t.timestamps
    end
  end
end
