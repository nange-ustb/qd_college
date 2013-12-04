# -*- encoding : utf-8 -*-
class Admin::RankingListYearsController < Admin::ResourceController
		helper_method :attributes
	has_scope :search , :only => [:index] ,:type => :hash, :default => {:name=>""}
	def index
	  	index!{
			respond_to do|f|
			      f.xls{
			      	titles = %w( 真实姓名 账号 金币数 分支 所在地区 手机号 所在单位 用户等级)
			      	attrs=["name","username","gold_count","user.zone.affiliate.name","user.zone.name","mobile","company", "level_text"]
			      	send_xls_data(collection,titles,attrs)
			      	return	       
			      }
			      f.html{}
			end 
		}
	end 

	private 
	def attributes
		["stage","name","username","zone_id","mobile","company","level_text", "gold_count"]
		#%w(名次 时间（周） 真实姓名 账号 金币数 所在地区 手机号 所在单位 用户等级)
	end 
end
