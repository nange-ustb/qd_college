# -*- encoding : utf-8 -*-
class ReadingsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_user_level
  def show
  	@document= Document.find_by_id params[:id]
  	if @document.blank? or @document.type!="Document" or !@document.can_view
  		redirect_to :back and return
  	end 
  	@document.increment!(:view_count)

  end

  def download
  	@document= Document.find_by_id params[:id]
  	if @document and @document.type=="Document" and @document.can_download
  		@document.increment!(:download_count)
  		send_file "#{Rails.root}/public/#{@document.file.link_url}"
  	else
  		redirect_to :back and return
  	end 
  end
  
  private 
    def check_user_level
      @document= Document.find_by_id params[:id]
      user_level= current_user.try(:student).try(:level) 
      able= case user_level
      when "mediate"
        ['mediate'].include? @document.level  
      when "advanced"
        ['mediate', 'advanced'].include? @document.level  
      else
        false
      end 

      unless able
        flash[:notice] = "您当前的级别不可以操作资料!"
        redirect_to(root_path)  and return
      end
    end

end
