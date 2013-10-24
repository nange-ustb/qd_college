# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: zones
#
#  code         :integer          primary key
#  name         :string(255)
#  parent_id    :integer          default(0)
#  affiliate_id :integer
#  area_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: zones
#
#  code         :integer          primary key
#  name         :string(255)
#  parent_id    :integer          default(0)
#  affiliate_id :integer
#  area_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Zone < ActiveRecord::Base
  self.primary_key = 'code'
  attr_accessible :code, :name, :parent_id , :affiliate_id , :area_id
  belongs_to :area
  belongs_to :parent, :foreign_key => 'parent_id', :class_name => "Zone"
  belongs_to :affiliate
  has_many :users
  scope :available , lambda{ where{affiliate_id != "null" } }
  scope :of_area, lambda{|area_id|
    where(:area_id => area_id)
  }
  scope :provinces , lambda {  where(:parent_id => 0) }
  scope :of_citys , lambda {|province_id|
    where(:parent_id => province_id).available
  }
  scope :of_distircts , lambda { |city_id|
    where(:parent_id => city_id ).available
  }

  has_many :activity_variant_zones
  has_many :activity_variants , through: :activity_variant_zones

  def self.current
    Thread.current[:zone]
  end

  def self.current=(zone)
    Thread.current[:zone] = zone
  end

  def self.first_city
    Zone.of_citys(Zone.first.id).first
  end

  def root?
    parent_id == "0"
  end

  # 目前支持到二级节点
  def family_ids
    if root?
      Zone.of_citys(self.code).pluck(:code) << self.code
    else
      [self.code]
    end
  end

  def level
    if self.try(:parent).try(:parent).present?
      return 3
    elsif self.try(:parent).present?
      return 2
    else
      return 1
    end
  end

  def province
    if level == 1
      self
    elsif level == 2
      self.try(:parent)
    else
      self.try(:parent).try(:parent)
    end
  end

  def city
    if level == 2
      self
    elsif level == 3
      self.try(:parent)
    end
  end

  def district
    self if level == 3
  end

  def full_name
    "#{province.try(:name)}#{city.try(:name)}#{district.try(:name)}"
  end

  def self.init_zone_data
    Spreadsheet.client_encoding = 'UTF-8'
    book = Spreadsheet.open(File.join(Rails.root,'lib','zone_datas.xls'))
    Zone.delete_all
    Affiliate.delete_all
    Area.delete_all
    book.worksheets.each do |sheet|
      header = sheet.row(0)
      (1 .. sheet.last_row_index).each do |i|
        arr_tmp = sheet.row(i).compact#.collect{|i|i.strip}
        code = arr_tmp.first.to_s.to_i
        name = arr_tmp[1].to_s.strip
        affiliate_name = arr_tmp[2].to_s.strip
        affiliate_code = arr_tmp[3].to_s.to_i
        if code > 0 and code % 10000 == 0
          parent_id = 0
        elsif code > 0 and code % 100 == 0
          parent_id = code/10000*10000
        elsif code > 0 and code % 100 != 0
          parent_id = code/100*100
          parent_id = code/10000*10000  if  [31,11,12,50].include? code/10000
        end
        parent_id = nil if name == "县" or name == "市辖区" or name == "自治区直辖县级行政区划" or name == "省直辖县级行政区划"

        if affiliate_code.to_i != 0
          affiliate = Affiliate.find_or_create_by_name_and_code(:name => affiliate_name , :code => affiliate_code )
        end
        zone = Zone.create(:code => code , :name => name , :parent_id => parent_id ,:affiliate_id => affiliate.try(:id) )
        affiliate = nil
      end
    end

    area_datas = {"华北地区" => [10] , "东北地区" => [20] , "华东地区" => [30] , "华中地区" => [41,42,43] ,
                  "华南地区" => [44,45,46] ,"西南地区" => [50] , "西北地区" => [60]}
    area_datas.each do |k,v|
      cur_area = Area.create(:name => k , :code => v.first)
      v.each do |i|
        if i%10 != 0
          lt_edge = i*10000 ; gt_edge = (i+1)*10000
        else
          i = i/10 ; lt_edge = i*100000 ; gt_edge = (i+1)*100000
        end
        Zone.where{code >= lt_edge }.where{code < gt_edge}.update_all(:area_id => cur_area.code )
      end
    end
  end
end

