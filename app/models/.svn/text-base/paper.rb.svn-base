# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: papers
#
#  id          :integer          not null, primary key
#  exam_id     :integer
#  question_id :integer
#  finished    :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: papers
#
#  id          :integer          not null, primary key
#  exam_id     :integer
#  question_id :integer
#  finished    :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Paper < ActiveRecord::Base
  attr_accessible :exam_id, :question_id
  belongs_to :exam
  belongs_to :question
end
