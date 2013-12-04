# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: fight_papers
#
#  id            :integer          not null, primary key
#  fight_exam_id :integer
#  question_id   :integer
#  answer        :string(255)
#  result        :string(255)      default("none")
#  stage         :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

# -*- encoding : utf-8 -*-
class FightPaper < ActiveRecord::Base
  extend Enumerize
  extend ActiveModel::Naming

  enumerize :result, in:[:none, :right, :wrong, :timeout], default: :none, :scope => true

  attr_accessible :fight_exam_id, :question_id, :answer, :stage

  belongs_to :fight_exam
  belongs_to :question_stand, :class_name => 'QuestionStand', :foreign_key => :question_id

  delegate :title, :a, :b, :c, :d, :e, :f, :answer, :to => :question_stand, :prefix => :question_stand, :allow_nil => true

  def expire_time
    created_at.since(1*60 + 0.5) - Time.now
  end

  def deal_with_answer(ans)
    FightPaper.transaction do
      self.answer = (ans || '').downcase
      if self.answer.blank?
        self.result = "timeout"
        fight_exam.fail
      elsif self.answer == self.question_stand.try(:answer).try(:downcase)
        self.result = "right"
        fight_exam.increment(:gold_count, 100)
        fight_exam.increment(:success_stage, 1)
        if fight_exam.current_stage == Setting.fight_stage
          fight_exam.succeed
        else
          fight_exam.increment(:current_stage, 1)
        end
      else
        self.result = "wrong"
        fight_exam.fail
      end
      self.save!
      fight_exam.save!
    end
    return self.result
  end

end
