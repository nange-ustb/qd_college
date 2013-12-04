# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: advertisements
#
#  id         :integer          not null, primary key
#  image_url  :string(255)
#  title      :string(255)
#  link_url   :string(255)
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Advertisement < ActiveRecord::Base
	include UpdatePosition
  attr_accessible :image_url, :title ,:link_url ,:position
  mount_uploader :image_url, AdvertisementUploader
  validates :title ,uniqueness: true, :presence => true , :allow_blank => false
  validates :link_url, :format => { :with => /[a-zA-z]+:\/\/[^\s]*/  , :message => "请填写正确的url地址！"}
  validates :image_url,:link_url , :presence => true
end
