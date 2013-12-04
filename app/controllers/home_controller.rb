# -*- encoding : utf-8 -*-
class HomeController < ApplicationController
  def index
  end

  def login_validate
    #return json {:result => true/false, :global_id => id }
    session[:user_return_to] = nil
    response = Faraday.post('http://sso.glodon.com/bit_client_sessions/login', {loginname: params[:loginname], password: params[:password]})
    if JSON.parse(response.body)['result']
      render :json => {:result => true}.to_json
    else
      render :json => {:result => false, :error_message => '用户名或密码不正确'}
    end
  end
end
