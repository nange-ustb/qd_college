# -*- encoding : utf-8 -*-
class Admin::UsersController < Admin::ResourceController
  helper_method :attributes
  has_scope :search , :only => [:index] ,:type => :hash, :default => {:username=>""}
  def index
  	index!{
		respond_to do|f|
		      f.xls{
		      	 titles = %w(分支 用户名 邮箱 姓名 电话 所在地区 公司 公司地址 用户级别)
		      	attrs = ["zone.affiliate.name","username","email","name","mobile","zone.name","company", "company_address", "level_text"]
		      	send_xls_data(collection,titles,attrs)
		      	return	       
		      }
		      f.html{}
		end 
	}
  end

  def reset_password
  	@user= User.find params[:id]
  	if @user.reset_password!("123456", "123456")
  		flash[:notice]="#{@user.username}的密码重置成功"
  	end 
  	redirect_to :back
  end 

  def enable
  	@user= User.find params[:id]
  	@user.status= params[:status]
  	if @user.save
  		flash[:notice]="操作成功"
  	end
  	redirect_to :back 	
  end 
  
  private 
  def attributes
  	["username",  "email","name","mobile", "zone_id","company", "company_address", "level"]
  end 
end
