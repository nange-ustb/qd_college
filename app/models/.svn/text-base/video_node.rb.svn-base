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
class VideoNode < ActiveRecord::Base
  include UpdatePosition
  attr_accessible :link, :title, :video_id,:position

  validates :title ,uniqueness: true, :presence => true , :allow_blank => false
  validates :link, :format => { :with => /[a-zA-z]+:\/\/[^\s]*/  , :message => "请填写正确的url地址！"}
  validates :link , :presence => true
  belongs_to :video

  scope :order_position , lambda{where{}}
end
