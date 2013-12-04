# -*- encoding : utf-8 -*-
class Admin::AwardRecordsController < Admin::ResourceController
	helper_method :attributes
  has_scope :search , :only => [:index] ,:type => :hash, :default => {:username=>""}
  def index
  	index!{
		respond_to do|f|
		      f.xls{
		      	 titles = %w(获奖来源 奖品名称 真实姓名 账号 手机号 分支 所在地区 详细地址 所在单位 获奖日期)
		      	attrs=["level_text","title","name","username","mobile","user.zone.affiliate.name","user.zone.name","address","company", "created_at"]
		      	send_xls_data(collection,titles,attrs)
		      	return	       
		      }
		      f.html{}
		end 
	}
  end

  private 
  def attributes
  	["level","title","name","username","mobile","zone_id","address","company", "created_at"]
  #	%w(获奖来源 奖品名称 真实姓名 账号 手机号 所在地区 详细地址 所在单位 获奖日期)
  end 
end
