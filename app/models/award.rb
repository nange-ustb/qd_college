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

class Award < ActiveRecord::Base
  include Redis::Objects
  validates :code , :uniqueness => {:scope => :game_id } , :presence => true , :allow_blank => false
  validates :title , :presence => true , :allow_blank => false
  validates :probability , :presence => true , :allow_blank => false
  validates :probability, inclusion: { in: 0.0001..1 }
  validates :count , :presence => true , :allow_blank => false

  belongs_to :game
  attr_accessible :code, :probability, :count , :game_id,:title
  counter :left_count
  scope :not_over , where{ count > 0 }
  scope :over , where{ count <= 0 }
  after_save :update_left_count_in_redis!
  # update_digit_pool!
  def update_left_count_in_redis!
    self.left_count.clear
    self.left_count.incr self.count
    self.game.update_digit_pool!
  end
  
  def update_left_count_into_db!
    self.count = self.left_count.value
    self.save if self.changed?
    self
  end
end
