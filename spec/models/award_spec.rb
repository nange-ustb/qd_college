# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: awards
#
#  id          :integer          not null, primary key
#  code        :string(255)      not null
#  title       :string(255)      not null
#  probability :float            not null
#  count       :integer          not null
#  game_id     :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Award do
  pending "add some examples to (or delete) #{__FILE__}"
end
