# -*- encoding : utf-8 -*-
class AddQuestionFileIdToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :question_file_id, :integer
  end
end
