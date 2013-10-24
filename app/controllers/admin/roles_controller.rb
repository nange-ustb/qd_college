# -*- encoding : utf-8 -*-
class Admin::RolesController < Admin::ResourceController
  # authorize_resource
  has_scope :search , :only => [:index] , :type => :hash

  def update
		update! do |success, failure|
	      failure.html { render :action=>:edit,:error=>'失败' }
	      success.html { 
	      	redirect_to edit_admin_role_path(resource),:notice=>'成功'
	      }
	    end
	end

  def create
		create! do |success, failure|
	      failure.html { render :action=>:new ,:error=>'失败'}
	      success.html { 
	      	redirect_to edit_admin_role_path(resource,:notice=>'成功')
	      }
	    end
  end
end
