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
class QuestionOnline < Question 
	enumerize :category, in:[:beginner,:mediate,:advanced], default: :beginner, :scope => true
	has_many :exams,:through => :papers
	validates  :category, presence: true
end
