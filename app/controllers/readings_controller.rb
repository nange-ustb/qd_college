# -*- encoding : utf-8 -*-
class ReadingsController < ApplicationController
  before_filter :authenticate_user!,:only=>[:download]
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

end
