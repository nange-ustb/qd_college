# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_user_return_to, :only => [:new]
  before_filter :check_forbidden_user

  private
  def set_user_return_to
    session["user_return_to"] = params[:redirect_to] || request.referer if params[:controller] == "devise/cas_sessions"
  end

  def check_forbidden_user
  	if current_user and current_user.off?
    		render :text=>"对不起，无论如何，您被禁闭了。<a href='users/sign_out'>退出后浏览</a>"
    	end
  end

end
