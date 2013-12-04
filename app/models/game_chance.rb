# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: game_chances
#
#  id         :integer          not null, primary key
#  student_id :integer          not null
#  game_id    :integer          not null
#  used       :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  level      :string(255)
#

# -*- encoding : utf-8 -*-
# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: game_chances
#
#  id         :integer          not null, primary key
#  student_id :integer          not null
#  game_id    :integer          not null
#  used       :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  level      :string(255)
#

# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: game_chances
#
#  id         :integer          not null, primary key
#  student_id :integer          not null
#  game_id    :integer          not null
#  used       :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  level      :string(255)
#
class GameChance < ActiveRecord::Base
  extend Enumerize
  enumerize :level, in:[:beginner,:mediate,:advanced],:default=>:beginner, :scope => true
  attr_accessible :game_id, :student_id, :used,:level
  belongs_to :student
  belongs_to :game

  scope :unused,where{used.eq false}
  default_scope { order('created_at desc') }
end
