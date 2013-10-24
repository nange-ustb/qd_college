# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: exams
#
#  id         :integer          not null, primary key
#  level      :string(255)
#  student_id :integer
#  correct    :integer
#  incorrect  :integer
#  pass       :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# -*- encoding : utf-8 -*-
# -*- encoding : utf-8 -*-
class Exam < ActiveRecord::Base
  extend Enumerize
  extend ActiveModel::Naming
  attr_accessible :correct, :incorrect, :pass, :level, :student_id,:questions_attributes
  enumerize :level, in:[:beginner,:mediate,:advanced],:default=>:beginner,scope: true
  # enumerize :state, in:[:true,:false],:default=>:false,scope: true
  has_many :questions, :through => :papers
  has_many :papers , :dependent => :destroy
  belongs_to :student
  accepts_nested_attributes_for :questions, :allow_destroy => true

  before_create :generate_papers
  scope :order_time_desc,->{order("created_at desc")}
  scope :unfinished,->{where{finished.eq false}}
  scope :finished,->{where{finished.eq true}}

  def spare_exam_time
     @spare_time ||= created_at.since((exam_time_limit + 0.5).minutes) - Time.now
  end

  def generate_papers
    random_questions = QuestionOnline.random_questions(self.level,exam_question_limit)
    # random_questions = QuestionOnline.random_questions(self.level,2)
    self.questions = random_questions
  end

  def calculate_achievement(answers)
    standard_answers = questions.map(){|q|{"id"=>q.id.to_s,"answer" =>q.answer.strip}}
    self.incorrect = (standard_answers - answers).size
    self.correct = exam_question_limit - self.incorrect
    self.pass = (exam_correct_limit <= self.correct)
    self.finished = true
    return promote_student_level
  end

  def promote_student_level
    student.promote_level(self.level)  if self.pass
    return student
  end

  %w(time question  correct).each do |key|
    method_name = "exam_#{key}_limit"
    define_method method_name.to_sym do
      Setting.send("#{method_name}s".to_sym)[self.level]
    end
  end
end
