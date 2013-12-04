# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: documents
#
#  id             :integer          not null, primary key
#  title          :string(255)
#  body           :text
#  author         :string(255)
#  level          :string(255)
#  topic          :string(255)
#  can_download   :boolean          default(FALSE)
#  can_view       :boolean          default(FALSE)
#  position       :integer          default(0)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  download_count :integer          default(0)
#  view_count     :integer          default(0)
#  type           :string(255)      default("Document")
#

# -*- encoding : utf-8 -*-
# -*- encoding : utf-8 -*-
# -*- encoding : utf-8 -*-
class Video < Document
  attr_accessible :body, :level, :title, :topic, :author
  has_many :video_nodes,dependent: :destroy
end
