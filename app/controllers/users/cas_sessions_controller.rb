# -*- encoding : utf-8 -*-
class Users::CasSessionsController < Devise::CasSessionsController
  def service
    if user_signed_in? and session[:has_redirected].blank? and current_user.created_at.since((1).minutes) - Time.now > 0
      session[:has_redirected] = true
      redirect_to(cas_login_url)    and return
    end

    redirect_to after_sign_in_path_for(warden.authenticate!(:scope => resource_name))
  end
end

