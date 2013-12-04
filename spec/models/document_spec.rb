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
require 'spec_helper'

describe Document do
  pending "add some examples to (or delete) #{__FILE__}"
end
