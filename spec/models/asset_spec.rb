# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: assets
#
#  id            :integer          not null, primary key
#  title         :string(255)
#  link          :string(255)
#  body          :text
#  desc          :string(255)
#  position      :integer          default(0)
#  type          :string(255)
#  viewable_type :string(255)
#  viewable_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Asset do
  pending "add some examples to (or delete) #{__FILE__}"
end
