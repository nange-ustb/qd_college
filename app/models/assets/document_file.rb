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
class DocumentFile < Asset
	attr_accessible :body, :desc, :link, :position, :title, :type, :viewable_id, :viewable_type
  mount_uploader :link, DocumentFileUploader
  after_save :deal_with_ppt
  def deal_with_ppt
  	self.viewable.ppt_2_swf
  end 
end
