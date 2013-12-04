# -*- encoding : utf-8 -*-
class Users::RegistrationsController < Devise::RegistrationsController

  def edit
    current_user.build_user_header unless current_user.user_header
    session[:referrer] = request.referrer || "/"
    render :edit
  end

  def update
    flash[:notice]= '更新成功' if current_user.update_attributes(resource_params)
    if current_user.errors.blank?
      redirect_to(session.delete(:referrer) || request.referrer || "/") and return
    else
      render "edit"
    end
  end

  def check_uniq
    @user = User.new(params[:user])
    render :json => @user.check_register_uniq
  end

  private
  def permit_params
    resource_params
  end
end


