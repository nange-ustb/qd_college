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
require 'spec_helper'

describe Exam do
  pending "add some examples to (or delete) #{__FILE__}"
end
