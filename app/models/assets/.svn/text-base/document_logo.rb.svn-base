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
class DocumentLogo < Asset
  attr_accessible :link, :position, :type, :viewable_id, :viewable_type
  mount_uploader :link, DocumentLogoUploader
end
