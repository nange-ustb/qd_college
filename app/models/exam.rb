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
#  finished   :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# -*- encoding : utf-8 -*-
# -*- encoding : utf-8 -*-
# -*- encoding : utf-8 -*-
class Exam < ActiveRecord::Base
  extend Enumerize
  extend ActiveModel::Naming
  attr_accessible :correct, :incorrect, :pass, :level, :student_id,:questions_attributes
  enumerize :level, in:[:beginner,:mediate,:advanced],:default=>:beginner,scope: true
  # enumerize :finished, in:[:true,:false],:default=>:false,scope: true
  enumerize :pass, in:[:true,:false],:default=>:false,scope: true
  has_many :questions, :through => :papers
  has_many :papers , :dependent => :destroy
  belongs_to :student
  accepts_nested_attributes_for :questions, :allow_destroy => true

  before_create :generate_papers
  
  scope :order_time_desc,->{order("created_at desc")}
  scope :unfinished,->{where{finished.eq false}}
  scope :finished,->{where{finished.eq true}}

  scope :of_student,->student_id {where{student_id.eq student_id}}

  scope :search , lambda{|params|
    where{
      conds = []
      conds << ( student_id.eq params[:student_id] ) if params[:student_id].present?
      conds << ( level.eq params[:level] ) if params[:level].present?
      conds.inject{| conds_total , con |  conds_total &= con }
    }
  }

  def self.beginner_student_count
     @beginner_student_count ||= pluck(:student_id).uniq.size
  end

  def self.mediate_student_count
    @mediate_student_count ||= (with_level(:mediate).pluck(:student_id) + with_level(:advanced).pluck(:student_id) ).uniq.size
  end

  def self.advanced_student_count
    @advanced_student_count ||= with_level(:advanced).pluck(:student_id).uniq.size
  end

  def spare_exam_time
     @spare_time ||= created_at.since((exam_time_limit).minutes) - Time.now
  end

  def generate_papers
    random_questions = QuestionOnline.random_questions(self.level,exam_question_limit)
    # random_questions = QuestionOnline.random_questions(self.level,2)
    self.questions = random_questions
  end

  def calculate_achievement(answers,current_student)
    standard_answers = questions.map(){|q|{"id"=>q.id.to_s,"answer" =>q.answer.strip}}
    self.incorrect = (standard_answers - answers).size
    self.correct = exam_question_limit - self.incorrect
    self.pass = (exam_correct_limit <= self.correct)
    self.finished = true
    current_student.promote_level(self) if self.pass == "true"
    current_student.fill_exam_record(self)
  end

  %w(time question  correct).each do |key|
    method_name = "exam_#{key}_limit"
    define_method method_name.to_sym do
      Setting.send("#{method_name}s".to_sym)[self.level]
    end
  end
end
