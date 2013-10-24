# -*- encoding : utf-8 -*-
#encoding:utf-8
include ApplicationHelper
class AdminController < ActionController::Base
  before_filter CASClient::Frameworks::Rails::Filter
  before_filter :set_administrator_for_cas, :set_current_administrator, :except => [:logout]
  skip_filter :filter_ip
  layout "admin"
  
  def logout
    CASClient::Frameworks::Rails::Filter.logout(self)
  end

  def set_administrator_for_cas
    cas_user_name = session[:cas_user]
    mail = session[:cas_extra_attributes][:mail]
    administrator = Administrator.find_by_user_name(cas_user_name)
    if administrator.present?
      if current_administrator.blank?
        sign_in(:administrator, administrator)
      end
      set_current_administrator
    else
      render :text=>"抱歉，没有访问权限<a href='admin/logout'>退出</a>"
    end
  end

  def set_current_administrator
    Administrator.current = current_administrator
  end

  private
  def current_ability
    @current_ability = session[:current_ability] || Ability.new(current_administrator)
    session[:current_ability] = @current_ability
  end
end
