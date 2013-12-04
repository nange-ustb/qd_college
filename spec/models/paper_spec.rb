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
require 'spec_helper'

describe Paper do
  pending "add some examples to (or delete) #{__FILE__}"
end
