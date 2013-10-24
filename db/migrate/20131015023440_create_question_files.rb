# -*- encoding : utf-8 -*-
class CreateQuestionFiles < ActiveRecord::Migration
  def change
    create_table :question_files do |t|
      t.string :question_type 
      t.string :title
      t.string :file_url
      t.boolean :is_inport , :default=> false

      t.timestamps
    end
  end
end
