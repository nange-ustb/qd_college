# -*- encoding : utf-8 -*-
class Admin::ExamRecordsController < Admin::ResourceController
	has_scope :search , :only => [:index] ,:type => :hash, :default => {:username=>""}
	def index
	  	index!{
			respond_to do|f|
			      f.xls{
			      	 titles = %w(分支 所在地区 真实姓名 账号 正确数 闯关次数 是否通关 手机号 所在单位 等级 )
			      	attrs=["user.zone.affiliate.name","user.zone.name","name","username","correct","exam_count","pass","mobile","company", "level_text"]
			      	send_xls_data(collection,titles,attrs)
			      	return	       
			      }
			      f.html{}
			end 
		}
	end 
	private 
	def attributes
		["zone_id","name","username","correct","exam_count",'pass',"mobile","company","level"]
		#%w(名次 时间（周） 真实姓名 账号 金币数 所在地区 手机号 所在单位 用户等级)
		# %w(名次 所在地区 真实姓名 账号 正确数 闯关次数 是否通关 手机号 所在单位 用户等级 correct exam_count)
	end 
end
