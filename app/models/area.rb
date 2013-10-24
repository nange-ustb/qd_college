# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: areas
#
#  name       :string(255)
#  code       :integer          primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Area < ActiveRecord::Base
  attr_accessible :name, :code
  self.primary_key = 'code'
  has_many :zones

  default_scope lambda{
    unless Administrator.current.blank? or Administrator.current.has_role?('superman')
      where(
          {'code' => Administrator.current.affiliates.pluck(:area_id)}
      ).readonly(false)
    end
  }

  scope :of_administrator, lambda{
    unless Administrator.current.blank? or Administrator.current.has_role?('superman')
      where(
          {'code' => Administrator.current.affiliates.pluck(:area_id)}
      ).readonly(false)
    end
  }

  def affiliates_of_administrator
    Administrator.current.affiliates.where(:area_id => self.id)
  end
end
