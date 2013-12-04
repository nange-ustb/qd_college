# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: video_nodes
#
#  id         :integer          not null, primary key
#  link       :string(255)
#  title      :string(255)
#  video_id   :integer
#  position   :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# -*- encoding : utf-8 -*-
# -*- encoding : utf-8 -*-
require 'spec_helper'

describe VideoNode do
  pending "add some examples to (or delete) #{__FILE__}"
end
