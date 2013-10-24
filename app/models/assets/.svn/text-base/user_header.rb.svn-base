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
# == Schema Information
#
# Table name: assets
#
#  id                      :integer          not null, primary key
#  viewable_id             :integer
#  viewable_type           :string(255)
#  attachment_width        :integer
#  attachment_height       :integer
#  attachment_file_size    :integer
#  position                :integer
#  attachment_content_type :string(255)
#  attachment_file_name    :string(255)
#  type                    :string(75)
#  attachment_updated_at   :datetime
#  alt                     :text
#  url                     :string(255)
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  title                   :string(255)
#
class UserHeader < Asset
	mount_uploader :url, UserHeaderUploader

  attr_accessible :link
end
