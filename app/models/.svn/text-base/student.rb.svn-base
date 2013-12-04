# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: students
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  level      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  pass       :boolean          default(FALSE)
#

# -*- encoding : utf-8 -*-
# -*- encoding : utf-8 -*-
# -*- encoding : utf-8 -*-
# -*- encoding : utf-8 -*-
class Student < ActiveRecord::Base
  extend Enumerize
  attr_accessible :level, :user_id
  enumerize :level, in:[:beginner,:mediate,:advanced],:default=>:beginner, :scope => true
  has_many :exams,dependent: :destroy
  belongs_to :user
  has_many :game_chances, dependent: :destroy
  has_many :exam_records, dependent: :destroy

  after_save :syn_user_level
  before_create :init_exam_records

  def syn_user_level
    self.user.level=self.level
    self.user.save 
  end 

  def init_exam_records
    self.class.level.values.each do |l|
      exam_records.build(:level=>l,:user_id=>self.user_id)
    end
  end

  def is_in_accordance_with_the_student_level?(current_level)
  	student_level_index,current_level_index = level_index(self.level),level_index(current_level)
  	student_level_index += 1 if self.pass
    student_level_index = 0 if level_index(level) == 0
    current_level_index <= student_level_index 
  end

  def promote_level(exam)
    return if (level_index(exam.level) < level_index(self.level))
    unless last_level?
      self.level = next_level
    else
      self.pass = true
    end
  end

  def prev_level
    return self.level if first_level?
    level_values[level_index(level) - 1]
  end

  def next_level
    return self.level if last_level?
    level_values[level_index(level) + 1]
  end

  def first_level?
    level_values.first == self.level
  end

  def last_level?
    level_values.last == self.level
  end

  def level_options
     @options ||= Hash[self.class.level.options].invert
  end

  def level_values
  	@level_values ||= self.class.level.values
  	@level_values
  end

  def level_index(current_level)
    return level_values.index(current_level)
  end

  def take_the_game_chance
    if game_chance_level
      game_id = Game.with_level(game_chance_level).pluck(:id).first
      game_chances.build(:game_id=>game_id,:level=>game_chance_level,:used=>false)
    end
  end

  def game_chance_level
    @game_chance_level ||= prev_level if level_changed? 
    @game_chance_level ||=  self.level  if pass_changed? 
    @game_chance_level
  end

  def fill_exam_record(exam)
    exam_record = exam_records.with_level(exam.level).first
    exam_record.exam_count += 1
    exam_record.correct = [exam_record.correct.to_i,exam.correct.to_i].max
    exam_record.pass = self.level_changed? || self.pass_changed? || exam_record.pass
    exam_records << exam_record
  end
end
