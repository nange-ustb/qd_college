# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: questions
#
#  id               :integer          not null, primary key
#  title            :string(255)
#  context          :text
#  a                :string(255)
#  b                :string(255)
#  c                :string(255)
#  d                :string(255)
#  e                :string(255)
#  f                :string(255)
#  answer           :string(255)
#  type             :string(255)
#  category         :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  question_file_id :integer
#

# -*- encoding : utf-8 -*-
class Question < ActiveRecord::Base
  attr_accessible :a, :answer, :b, :c, :category, :context, :d, :e, :f, :title, :type,:question_file_id

  extend Enumerize
  extend ActiveModel::Naming

  belongs_to :question_file
# enumerize :answer, in:[:a, :b, :c ,:d ,:e ,:f]

  validates :title, :answer, :a, :b, presence: true

  before_validation :underscore_answer

  def underscore_answer
    self.answer= self.answer.strip.downcase if self.answer
  end 

  def self.random_questions(level,size)
    with_category(level).random(size)
  end

  scope :search , lambda{|params|
    where{
      conds = []
      conds << ( category.eq params[:category] ) if params[:category].present?
      conds << ( title =~ ("%" + params[:title] +"%") ) if params[:title].present?
      conds << ( question_file_id.eq params[:question_file_id] ) if params[:question_file_id].present?
      conds.inject{| conds_total , con |  conds_total &= con }
    }.order("created_at desc")
  }
end
