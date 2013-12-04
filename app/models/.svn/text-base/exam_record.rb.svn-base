# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: exam_records
#
#  id         :integer          not null, primary key
#  student_id :integer
#  user_id    :integer
#  correct    :integer          default(0)
#  level      :string(255)
#  exam_count :integer          default(0)
#  pass       :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# -*- encoding : utf-8 -*-
class ExamRecord < ActiveRecord::Base
  extend Enumerize
  attr_accessible :correct, :exam_count, :level, :student_id, :user_id,:pass
  enumerize :level, in:[:beginner,:mediate,:advanced],:default=>:beginner, :scope => true
# %w(名次 所在地区 真实姓名 账号 正确数 闯关次数 是否通关 手机号 所在单位 用户等级 correct exam_count)
  delegate :name,:username,:mobile,:zone_id,:company, to: :user, allow_nil:  true

  belongs_to :user
  belongs_to :student
  scope :pass,lambda{where(:pass=> true)}
  scope :nopass,lambda{where(:pass=> false)}
  scope :valid,lambda{where{exam_count.gt 0}}

  scope :search , lambda{|params|
    includes(:user=>:zone).where{
      conds = []
      conds << ( pass.eq params[:pass] ) if params[:pass].present?
      conds << ( user.name =~ ("%" + params[:name] +"%") ) if params[:name].present?
      conds << ( user.username =~ ("%" + params[:username] +"%") ) if params[:username].present?
      conds << ( user.zone.affiliate_id.eq params[:affiliate_id] ) if params[:affiliate_id].present?
      conds << ( user.zone_id.eq params[:zone_id] ) if params[:zone_id].present?
      conds << ( level.eq params[:level] ) if params[:level].present?
      conds << ( user.zone_id.in Zone.where(:parent_id => params[:province_id]).pluck(:code) ) if params[:zone_id].blank? and params[:province_id].present?
      conds.inject{| conds_total , con |  conds_total &= con }
    }.valid.order(" exam_records.#{params[:order].present? ?  params[:order]: 'exam_count' } desc")
  }

  default_scope lambda{
    unless Administrator.current.blank? or Administrator.current.has_role?('superman')
      includes(:user=>:zone).where{
      	conds = []
      	conds << ( user.zone.affiliate_id.in Affiliate.of_administrator.pluck(:code) ) 
          conds.inject{| conds_total , con |  conds_total &= con }
      }.readonly(false)
    end
  }

  def self.order_str(key)
  	{:exam_asc=>"exam_records.exam_count,exam_records.created_at asc",
  	:exam_desc=>"exam_records.exam_count desc,exam_records.created_at asc",
  	:correct_asc=>"exam_records.correct,exam_records.created_at asc",
  	:correct_desc=>"exam_records.correct desc,exam_records.created_at asc"
  }[key.to_s.to_sym] || "exam_records.correct desc,exam_records.created_at asc"
  end
end
