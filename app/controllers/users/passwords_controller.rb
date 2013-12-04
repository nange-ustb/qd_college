# -*- encoding : utf-8 -*-
class Users::PasswordsController < Devise::PasswordsController
	# layout  "order_common"
 #  include SimpleCaptcha::ControllerHelpers
 #  skip_filter :detect_current_location
 #  before_filter :valid_captcha,:only => [:create]

 #  def create
 #    u = resource_class.new(resource_params)
 #    self.resource = resource_class.send_reset_password_instructions(username: u.loginname)
 #    valid_user
 #    if  resource.is_email?
 #      render "email"  and return
 #    elsif resource.is_mobile?
 #      set_sms_code_and_reset_token
 #      render "mobile"  and return
 #    end
 #  end

 #  def update
 #    self.resource = resource_class.reset_password_by_token(resource_params)
 #    if resource.errors.empty?
 #      flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
 #      set_flash_message(:notice, flash_message) if is_navigational_format?
 #      render 'success'
 #    else
 #      respond_with resource
 #    end
 #  end

 #  private
 #  def valid_captcha
 #    unless simple_captcha_valid?
 #      flash[:captcha] = '请输入正确的验证码！'
 #      redirect_to :back   and return
 #    end
 #  end

 #  def valid_user
 #    if resource.new_record?
 #      flash[:user] = '用户不存在'
 #      redirect_to :back   and return
 #    end
 #  end

 #  def assert_reset_token_passed
 #    params[:reset_password_token] ||= sms_reset_password_token
 #    if params[:reset_password_token].blank?
 #      set_flash_message(:error, :no_token)
 #      redirect_to new_session_path(resource_name)
 #    end
 #  end

 #  def set_sms_code_and_reset_token
 #    session[:sms_code] =  resource.code
 #    session[:sms_reset_token] =  resource.reset_password_token.split(resource.code).first
 #  end

 #  def sms_reset_password_token
 #    session[:sms_reset_token].to_s +  session[:sms_code].to_s
 #  end
end
