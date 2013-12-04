# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: award_records
#
#  id             :integer          not null, primary key
#  title          :string(255)
#  code           :string(255)
#  level          :string(255)
#  user_id        :integer
#  game_chance_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  username       :string(255)
#  affiliate_id   :integer
#  zone_id        :integer
#  zone_name      :string(255)
#

# -*- encoding : utf-8 -*-
# -*- encoding : utf-8 -*-
# -*- encoding : utf-8 -*-
# -*- encoding : utf-8 -*-
# -*- encoding : utf-8 -*-
# -*- encoding : utf-8 -*-
require 'spec_helper'

describe AwardRecord do
  pending "add some examples to (or delete) #{__FILE__}"
end
