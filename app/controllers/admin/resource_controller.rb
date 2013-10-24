# -*- encoding : utf-8 -*-
require_dependency "application_controller"
class Admin::ResourceController < AdminController
  inherit_resources
  authorize_resource
  
  helper_method :attributes,:current_resource_name

  layout "admin/backend"
  respond_to :html
  has_scope :page, :default => 1, :allow_blank => true, :unless => :require_complete_data

  rescue_from CanCan::AccessDenied do |exception|
    flash[:notice] = exception.message
    render :permission_denied and return
  end

  def order
    resource_class = params[:t].constantize if params[:t].present?
    ids = params[:setname].dup.map(&:to_i)
    objs = ids.map{|id|  resource_class.find id}
    positions = objs.collect(&:position).sort
    objs.each_with_index{|obj , i|
      obj.update_attribute(:position,positions[i])
    }
    render nothing: true
  end

  def update_positions
    params[:positions].each do |id, index|
      resource_class.where(:id => id).update_all(:position => index)
    end

    respond_to do |format|
      format.js  { render :text => 'Ok' }
    end
  end

  private
    def current_resource_name
      resource_class.to_s.underscore
    end

    def attributes
      resource_class.attribute_names - %w(id created_at updated_at)
    end

    def require_complete_data
      params[:format] == "xls"
    end

    def send_xls_data(objs,titles,attrs)
      xls_content = ExcelReport.report(objs,titles,attrs)
      send_data(xls_content,
                :type => "text/excel;charset=utf-8; header=present",
                :disposition => "attachment; filename=#{Time.now.strftime("%Y%m%d")}.xls")
      return
    end

end

