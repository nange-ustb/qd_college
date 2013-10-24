# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: permission_events
#
#  id            :integer          not null, primary key
#  permission_id :integer
#  event_id      :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class PermissionEvent < ActiveRecord::Base
  attr_accessible  :event_id , :permission_id
  belongs_to :event
  belongs_to :permission
end
