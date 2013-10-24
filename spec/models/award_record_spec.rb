# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: award_records
#
#  id             :integer          primary key
#  title          :string(255)
#  code           :string(255)
#  user_id        :integer
#  game_chance_id :integer
#  created_at     :datetime
#  updated_at     :datetime
#

# -*- encoding : utf-8 -*-
require 'spec_helper'

describe AwardRecord do
  pending "add some examples to (or delete) #{__FILE__}"
end
