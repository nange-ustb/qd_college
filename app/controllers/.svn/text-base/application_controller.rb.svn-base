# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_user_return_to, :only => [:new]
  before_filter :check_forbidden_user
  helper_method %w(beginner_student_count mediate_student_count advanced_student_count)

  private
  %w(beginner_student_count mediate_student_count advanced_student_count).each do |method_name|
    # define_method(method_name.to_sym){session[method_name.to_sym ] ||= Exam.send method_name.to_sym} 
    define_method(method_name.to_sym){Exam.send method_name.to_sym} 
  end

  def set_user_return_to
    session["user_return_to"] = params[:redirect_to] || request.referer if params[:controller] == "devise/cas_sessions" and !(request.referer || '').match('/users/sign_up')
  end

  def check_forbidden_user
    if current_user.present? and current_user.off?
      unless controller_name=="cas_sessions" and action_name=="destroy"
        render :text=>"对不起，无论如何，您被禁闭了。<a href='/users/sign_out' >退出后浏览</a>"
      end
    end
  end
end
