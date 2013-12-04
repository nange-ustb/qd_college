# -*- encoding : utf-8 -*-
class UsersController < ApplicationController
  include SimpleCaptcha::ControllerHelpers
  before_filter :authenticate_user!#, :only => [:edit,:update]

  def edit
  end

  def update
    @user = UserBrother.find current_user.id
    if valid_captcha? and @user.reset_password!(params[:user][:password],params[:user][:password_confirmation])
      render :success
    else
      render :edit
    end
  end

  def level

  end

  def exam
    params[:user] ||= {}
    @exams = current_user.try(:student).exams.finished
    @exams = @exams.with_level(params[:user][:level]) if params[:user][:level].present?
    @exams=@exams.order_time_desc
  end

  def fight
  end

  private
  def valid_captcha?
    unless simple_captcha_valid?
      flash[:notice] = '密码修改失败，请输入正确的验证码！'
      return false
    else
      return true
    end
  end
end
