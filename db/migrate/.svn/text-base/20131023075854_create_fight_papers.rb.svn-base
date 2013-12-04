# -*- encoding : utf-8 -*-
class CreateFightPapers < ActiveRecord::Migration
  def change
    create_table :fight_papers do |t|
      t.references :fight_exam
      t.references :question
      t.string     :answer
      t.string     :result, :default => 'none', :commit => 'none right wrong timeout'
      t.integer    :stage
      t.timestamps
    end
  end
end
