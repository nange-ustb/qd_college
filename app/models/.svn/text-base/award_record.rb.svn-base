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
class AwardRecord < ActiveRecord::Base
  extend Enumerize
  enumerize :level, in:[:beginner,:mediate,:advanced],:default=>:beginner, :scope => true
  attr_accessible :game_chance_id, :code, :title, :user_id,:level
  belongs_to :user
end
