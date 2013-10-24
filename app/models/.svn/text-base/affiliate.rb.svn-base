# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: affiliates
#
#  name       :string(255)
#  code       :integer          primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# -*- encoding : utf-8 -*-
class Affiliate < ActiveRecord::Base
  attr_accessible :code, :name , :area_id , :area, :product_ids
  self.primary_key = 'code'

  has_many :product_affiliates, :dependent => :destroy
  accepts_nested_attributes_for :product_affiliates
  has_many :products, :through => :product_affiliates
  has_many :zones
  has_many :orders

  has_many :administrator_affiliates#, :dependent => :destroy
  has_many :administrators , :through => :administrator_affiliates

  #has_many :shelf_item_affiliates , :dependent => :destroy

  has_many :activity_affiliates
  has_many :activities , through: :activity_affiliates   , :dependent => :destroy

  scope :of_administrator, lambda{
    unless Administrator.current.blank? or Administrator.current.has_role?('superman')
      where(
          {:code => Administrator.current.affiliates.pluck(:code)}
      )
    end
  }

  def inside_citys
    inside_citys = self.zones.available.where{parent_id != "null" }#.where(" code%10000 = 0 ")

    inside_citys = unless  %w( 天津 北京 上海 重庆 ).include? self.name
                     inside_citys.where(" code%100 = 0 ")
                   else
                     inside_citys#.where(" code%100 != 0 ")
                   end

  end

end
