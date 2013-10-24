# -*- encoding : utf-8 -*-
class Admin::PermissionsController < Admin::ResourceController

	def update
		@permission = Permission.find(params[:id])
		ActiveRecord::Base.transaction do
			@permission.permission_events.destroy_all();
			if @permission.update_attributes(params[:permission])
				redirect_to edit_admin_permission_path(@permission) ,:notice=>'成功'  and return
			else
				redirect_to edit_admin_permission_path(@permission),:error=>'失败'
			end
		end
	end

	def create
		create! do |success, failure|
	      failure.html { render :action=>:new,:error=>'失败' }
	      success.html { 
	      	redirect_to edit_admin_permission_path(resource),:notice=>'成功'
	      }
	    end
	end
end
